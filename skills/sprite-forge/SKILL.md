---
name: sprite-forge
description: "Chuẩn hóa quy trình tạo 2D Sprite, Character, Monster, Prop & FX animation sheets. Tích hợp lưới Chroma (#FF00FF/#00FF00), khóa tỷ lệ cơ thể (Scale Profile Locking: character-scale-profile.json), tách biệt nghiêm ngặt Body vs FX, căn lề bàn chân (Feet alignment), tích hợp pixellab MCP + Antigravity generate_image, và xuất hợp đồng Godot Sprite2D/Sprite3D."
argument-hint: "[target:<type>] [mode:<action>] [--grid 2x2|2x3|2x4|3x3|4x4] [--style pixel_art|clean_hd|retro_pixel]"
user-invocable: true
allowed-tools: view_file, find_by_name, grep_search, write_to_file, replace_file_content, invoke_subagent, ask_question, run_command
model: inherit
---

# Sprite Forge: Quy Chuẩn Sản Xuất 2D Sprite & Hoạt Ảnh Đẳng Cấp Công Nghiệp

Kỹ năng này chịu trách nhiệm sinh và hậu xử lý toàn bộ tài nguyên Sprite 2D trong game (Player, Monster, NPC, Boss, Prop, Spell, Projectile, VFX, Summons). 

> **Nguyên tắc bất biến**: Mô hình AI chỉ tạo ra ảnh thô (Raw Sheet) trên phông nền Chroma đơn sắc (`#FF00FF` Magenta hoặc `#00FF00` Green). Toàn bộ khâu tách nền, chia khung hình, chuẩn hóa tỷ lệ và căn chỉnh trọng tâm PHẢI do các script xử lý pixel tất định (deterministic python processors) đảm nhận.

---

## 1. Phân Loại Tài Nguyên & Cấu Trúc Lưới (Grid Presets)

### Phân loại tài nguyên (`asset_type`):
- `player`: Nhân vật người chơi điều khiển
- `npc`: Dân làng, thương nhân, nhân vật giao nhiệm vụ
- `creature`: Quái vật, dã thú, boss, linh thú triệu hồi
- `character`: Đơn vị hình người góc nhìn ngang (side-view)
- `spell`: Chuỗi thi triển phép thuật / kỹ năng
- `projectile`: Đạn bay, cầu lửa, mũi tên, chùm tia lặp lại
- `impact`: Vụ nổ, tia tóe lửa, chớp va chạm khi trúng đòn
- `prop`: Vật phẩm rơi, vũ khí, rương đồ, bia đá, đèn đường
- `fx`: Hiệu ứng hạt, bụi chạy, vòng sáng aura

### Quy chuẩn lưới tạo ảnh (Sheet Grid Rules):
| Hành động (`action`) | Dạng thực thể | Cấu trúc lưới khuyến nghị | Ghi chú an toàn |
|---|---|---|---|
| `idle` | Nhân vật / NPC / Quái nhỏ | **`2x2`** (4 frames) | Giữ thân người ở trung tâm 65% ô |
| `idle` | Boss khổng lồ / Titan | **`3x3`** (9 frames) | Thở tại chỗ, khóa cố định xương chậu |
| `walk` / `run` | Side-view 2D | **`2x2`** hoặc **`2x3`** | Giữ đường tiếp đất (feet line) cố định |
| `walk` | Top-down 4 hướng | **`4x4`** (16 frames) | Hàng 1: Xuống, Hàng 2: Trái, Hàng 3: Phải, Hàng 4: Lên |
| `attack` / `cast` | Đòn đánh / Niệm phép | **`2x2`** hoặc **`2x3`** | **CHỈ VẼ THÂN**, tách riêng FX chém |
| `projectile` | Đạn bay loop | **`1x4`** hoặc **`2x2`** | Đạn luôn căn giữa ô |
| `impact` / `explode`| Vụ nổ | **`2x2`** (4 frames) | Nổ bung từ tâm |

> [!CAUTION]
> **CẤM TUYỆT ĐỐI**: Không bao giờ tạo ảnh nhân vật đơn dòng thô (`1x4`, `1x6`, `1x8`) bằng AI generator. Định dạng đơn dòng khiến AI bị trôi tọa độ ngang và co giãn kích thước thất thường. Luôn yêu cầu sinh dạng lưới ma trận (`2x2`, `2x3`, `2x4`, `3x3`, `4x4`).

---

## 2. Quy Tắc Khóa Tỷ Lệ Cơ Thể (Scale Profile Locking)

Hiện tượng nhân vật bị "teo nhỏ" khi vung kiếm bắt nguồn từ việc mô hình AI cố gắng nhét thanh kiếm dài vào khung ô vuông, khiến thuật toán Auto-Fit thu nhỏ toàn bộ cơ thể.

### Giải pháp Scale Profile:
1. **Master Reference Action**: Sinh hành động cơ bản trước (thường là `idle` hoặc `run`).
2. Sau khi hành động này được duyệt (QC Pass), chạy lệnh trích xuất và ghi lại **Scale Profile**:
   ```cmd
   cmd /c python catalog\game-studio\tools\generate2dsprite.py process --input <path/to/idle_raw.png> --target player --mode idle --rows 2 --cols 2 --cell-size 128 --fit-scale 0.80 --align feet --scale-strategy preserve --component-mode largest --strict-qc --write-scale-profile <bundle_dir>/character-scale-profile.json --profile-name <character_name> --max-profile-scale-drift 0.08
   ```
3. **Áp dụng cho mọi hành động tiếp theo**: Với các hành động như `attack`, `hurt`, `cast`, luôn truyền `--scale-profile <bundle_dir>/character-scale-profile.json`. Bộ tiền xử lý sẽ ép buộc kích thước ô, tỷ lệ pixel thực và vị trí chân của hành động mới phải khớp 100% với file profile gốc!

---

## 3. Nguyên Tắc Phân Tách Thân Người & Hiệu Ứng (Body vs FX Separation)

- **Sheet Cơ Thể (`Body Sheet`)**: Chỉ chứa nhân vật và vũ khí cầm sát người. Tuyệt đối không chứa vệt kiếm chém rộng (slash arcs), chớp lửa đầu nòng (muzzle flashes), bụi đất tung tóe, chùm tia phép.
- **Sheet Hiệu Ứng (`FX Sheet`)**: Sinh vệt chém kiếm hoặc tia sét trong một sheet riêng biệt (`asset_type: fx`). 
- **Tại sao?**: Khi tách rời, trong Godot Engine ta xếp layer `Sprite2D` của FX đè lên nhân vật. Điều này vừa giúp cơ thể nhân vật giữ nguyên tỷ lệ pixel chuẩn, vừa cho phép lập trình viên tái sử dụng hiệu ứng chém kiếm cho nhiều loại vũ khí khác nhau.

---

## 4. Quy Trình Vận Hành 5 Bước (Standard Operating Procedure)

### Bước 1: Chuẩn bị Prompt và Layout Guide (Tùy chọn)
Nếu cần lưới cố định để tránh tràn viền, tạo Layout Guide hình học trước:
```cmd
cmd /c python catalog\game-studio\tools\make_layout_guide.py --rows 2 --cols 2 --cell-width 384 --cell-height 384 --output <run_dir>/layout_guide.png
```

### Bước 2: Tạo Ảnh Thô (Raw Generation)
Có 2 phương thức tùy thuộc vào công cụ có sẵn:
1. **Sử dụng `pixellab` MCP (Ưu tiên hàng đầu cho Pixel Art chuẩn game)**:
   - Sử dụng `pixellab:create_character` hoặc `pixellab:animate_character`
   - Hoặc `pixellab:create_image_pixflux` / `pixellab:create_image_pixen` với prompt chỉ định phông nền `#FF00FF`.
2. **Sử dụng Antigravity Native `generate_image`**:
   - Prompt mẫu:
     ```text
     Pixel art 2D game sprite sheet, 2x2 grid (4 frames total), walking animation of a cyber ninja, side-view. Full body visible in every frame, subject centered in each cell occupying 65% safe area. Solid pure magenta background #FF00FF, strictly no shadows, no floor, no border lines, nothing crossing cell edges. Consistent scale and colors across all frames.
     ```

### Bước 3: Hậu Xử Lý Tất Định Bằng Python
Chạy script `generate2dsprite.py` để bóc tách nền magenta, khử viền răng cưa (despill), cắt frame, căn lề chân và xuất GIF:
```cmd
cmd /c python catalog\game-studio\tools\generate2dsprite.py process --input <raw_image.png> --output-dir <output_dir> --rows 2 --cols 2 --cell-size 128 --align feet --scale-strategy preserve --component-mode largest --strict-qc
```

### Bước 4: Kiểm Định Chất Lượng Tự Động (QC Gates)
Script tự động sinh file `pipeline-meta.json` chứa các chỉ số kiểm toán:
- `edge_touch_frames`: Phải là rỗng (`[]`). Nếu có chi tiết chạm mép ô $\rightarrow$ Tự động loại bỏ và sinh lại.
- `body_scale_cv`: Hệ số biến thiên kích thước cơ thể $\le 0.08$.
- `anchor_y_std`: Độ lệch chuẩn của đường tiếp đất chân $\le 0.05$.

### Bước 5: Xuất Hợp Đồng Godot Engine (`Sprite2D` & `Sprite3D`)
Khi chỉ định tham số `--godot-world-height <meters>` (ví dụ: `0.75`), script sẽ tự động tạo file hợp đồng `godot-sprite3d.json` hoặc `godot-sprite3d-bundle.json`:
- `recommended_pixel_size`: Tỷ lệ chuyển đổi pixel sang mét chuẩn xác trong Godot.
- `offset`: Tọa độ bù trừ trọng tâm để chân nhân vật luôn chạm sàn 3D/2D chuẩn xác.
- Danh sách frames và cấu hình `loop` vs `one_shot` sẵn sàng cho `AnimatedSprite2D` / `AnimatedSprite3D`.
