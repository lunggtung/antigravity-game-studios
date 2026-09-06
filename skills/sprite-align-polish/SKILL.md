---
name: sprite-align-polish
description: "Quy chuẩn kiểm định hoạt ảnh, bảo toàn khung hình canvas (Canvas Preservation Layout), đánh giá và khử rung lắc tiếp đất (Vertical Ground Alignment Assessment), và kiểm duyệt hoạt ảnh tương tác qua HTML5 Sprite Viewer."
argument-hint: "[input:<path/to/sheet_or_frames>] [--frames 16|24] [--layout preserve-canvas|fit-foreground] [--assess-vertical]"
user-invocable: true
allowed-tools: view_file, find_by_name, grep_search, write_to_file, replace_file_content, invoke_subagent, ask_question, run_command
model: inherit
---

# Sprite Align & Polish: Kiểm Định & Tinh Chỉnh Đẳng Cấp Hoạt Ảnh 2D

Kỹ năng này giải quyết bài toán: Hoạt ảnh tạo từ video (AI video generation hoặc chuỗi frame) bị rung lắc trục Y (vertical jitter), nhân vật nhảy lên đáp xuống bị lún chân xuống sàn gạch hoặc bay lơ lửng trên không trung, hoặc khoảng không gian xung quanh nhân vật bị xáo trộn giữa các hành động.

---

## 1. Nguyên Tắc Bảo Toàn Canvas (Preserve Canvas Layout)

Trong quá trình đóng gói các khung hình thành dải ngang (Horizontal Sprite Strip):
- **Sai lầm phổ biến**: Cắt xén (tight crop) từng khung hình sát rạt vào pixel nhân vật rồi dán vào giữa ô. Kết quả: Khi nhân vật giơ tay thì trọng tâm bị kéo lệch, khoảng cách từ đầu đến đỉnh ô bị méo mó.
- **Quy chuẩn Bảo toàn Canvas (`--layout-mode preserve-canvas`)**:
  Giữ nguyên kích thước khung vẽ chuẩn (ví dụ `256 x 256`). Mọi khoảng trống không gian phía trên đầu, hai bên vai và đường mặt đất đều được bảo tồn đồng bộ xuyên suốt từ hành động `idle`, `walk`, `jump` đến `attack`.

Lệnh chạy đóng gói dải hoạt ảnh chuẩn:
```cmd
cmd /c python catalog\game-studio\tools\animation_pipeline.py --source-frames-dir <work/extracted/character/action> --frames 24 --background-mode chroma --key "#00ff00" --layout-mode preserve-canvas --output <work/sheets/character_action_24f_256.png> --preview <work/previews/preview.png> --frames-dir <work/frames/action> --report <work/reports/report.json> --frame-prefix hero_action
```

---

## 2. Quy Trình Đánh Giá Tiếp Đất Trục Dọc (Vertical Alignment Assessment)

Với các hoạt ảnh có chuyển động theo chiều thẳng đứng như `jump`, `fall`, `landing`, `knockback`:
Chạy công cụ đánh giá tự động:
```cmd
cmd /c python catalog\game-studio\tools\vertical_alignment.py --input <path/to/sheet_24f_256.png>
```

### Các trạng thái phán quyết (Verdicts):
1. **`probably_no` / `probably_no_or_minor`**: Hoạt ảnh tiếp đất mượt mà, chân chạm đất chuẩn xác, không có hiện tượng rung giật $\rightarrow$ Đạt chuẩn (Pass), sẵn sàng tích hợp.
2. **`yes_likely` / `yes_but_constrained`**: Phát hiện chân nhân vật bị lún qua đường mặt đất sàn (floor penetration) hoặc bay lơ lửng bất thường giữa các frame $\rightarrow$ Cần chạy căn lề chân theo đường guideline mặt đất cố định.
3. **`review_manually`**: Cần người dùng quan sát bằng mắt qua Sprite Viewer trước khi can thiệp.

---

## 3. Trình Duyệt Kiểm Duyệt Hoạt Ảnh Tương Tác (Sprite Viewer)

Trước khi đưa tài nguyên vào thư mục chính thức của dự án game, khởi chạy máy chủ kiểm duyệt cục bộ:
```cmd
cmd /c node catalog\game-studio\tools\viewer\serve_sprite_viewer.mjs
```

### Các tính năng của Sprite Viewer:
- **Loop Playback**: Chạy vòng lặp hoạt ảnh với tùy chỉnh tốc độ FPS (12, 24, 30, 60 fps).
- **Ground Guideline (Đường dẫn mặt đất)**: Hiển thị thanh thước đo màu đỏ để kiểm tra xem bàn chân có bám sát mặt đất khi bước đi hay không.
- **Onion Skinning**: Hiển thị bóng mờ của khung hình trước/sau để kiểm tra độ mượt mà của quỹ đạo cử động.
- **Frame Step**: Dừng từng khung hình để phát hiện lỗi biến dạng (artifact/clipping).

---

## 4. Tiêu Chuẩn Thăng Hạng Tài Nguyên (Promotion Gate Checklist)

Chỉ copy tài nguyên vào thư mục `assets/sprites/` hoặc `Final Sprite Sheets/` khi thỏa mãn 100% các điều kiện sau:
- [ ] Báo cáo kiểm định `report.json` trả về status: `"pass"`.
- [ ] Kích thước dải sheet chuẩn xác: `(frames * 256) x 256` pixel.
- [ ] Không có bất kỳ frame nào bị đứt cụt vũ khí, tà áo hay tóc ở mép canvas.
- [ ] Tỷ lệ nhân vật không bị biến đổi so với bộ Scale Profile chuẩn.
- [ ] Đường tiếp đất không bị rung giật khi chạy ở 24 FPS.
