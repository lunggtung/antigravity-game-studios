---
name: character-layer-forge
description: "Quy chuẩn kiến trúc nhân vật đa tầng module hóa (Modular Character & Cosmetic Layer Pipeline). Tạo chuyển động cơ sở ảnh xám (Greyscale Base Animation), các lớp trang phục/tóc/mắt (Cosmetic Layers) khớp từng pixel, và tích hợp Godot Shader đổi màu thời gian thực."
argument-hint: "[character:<name>] [--base-motion idle|walk|run] [--layers hair,clothing,iris] [--export godot-shader]"
user-invocable: true
allowed-tools: view_file, find_by_name, grep_search, write_to_file, replace_file_content, invoke_subagent, ask_question, run_command
model: inherit
---

# Character Layer Forge: Quy Chuẩn Nhân Vật Đa Tầng Module Hóa

Kỹ năng này giải quyết bài toán lãng phí tài nguyên và khó tùy biến nhân vật trong game: Thay vì phải vẽ và lưu trữ hàng chục bộ sprite sheet cồng kềnh cho từng màu tóc, màu da, bộ quần áo của người chơi hoặc NPC, kiến trúc Đa Tầng Module Hóa chia nhân vật thành các lớp (Layers) khớp từng pixel và tô màu động bằng Shader trong Godot.

---

## 1. Kiến Trúc 2 Pipeline (The Two-Pipeline Architecture)

```
                            ┌─────────────────────────────────────────────────┐
                            │ Pipeline 1: CHUYỂN ĐỘNG CƠ SỞ (BASE ANIMATION)  │
                            └─────────────────────────────────────────────────┘
    Ảnh Nhân Vật Gốc ──► [Keyframe Posing] ──► [Motion Extrapolation] ──► base_motion.png (Greyscale RGBA)
                                                                                  │
                            ┌─────────────────────────────────────────────────┐   │ Khớp Pixel 100%
                            │ Pipeline 2: CÁC LỚP TRANG TRÍ (COSMETIC LAYERS) │   │ (Zero Re-alignment)
                            └─────────────────────────────────────────────────┘   ▼
    Tham chiếu Phụ Kiện ──► [Inpaint / Segment] ────────────────────────► cosmetic_hair.png
                                                                          cosmetic_clothing.png
                                                                          cosmetic_iris.png
```

### 1. Lớp Chuyển Động Cơ Sở (Base Animation)
- Định dạng: Ảnh xám RGBA (Greyscale PNG).
- Chứa toàn bộ cơ thể, khối cơ bắp, chân dung chuyển động (chạy, nhảy, thở, đánh).
- Điểm mấu chốt: Do là thang độ xám (luminance từ 0.0 đến 1.0), Shader có thể nhân với bất kỳ mã màu da nào của người chơi (`tint_color`).

### 2. Các Lớp Phụ Kiện Tách Rời (Cosmetic Layers)
- **Tóc (`cosmetic_hair.png`)**: Chỉ chứa các điểm ảnh của tóc, toàn bộ phần thân người được loại bỏ trong suốt.
- **Trang phục (`cosmetic_clothing.png`)**: Áo giáp, áo choàng, quần đùi.
- **Con ngươi mắt (`cosmetic_iris.png`)**: Tách riêng tròng mắt để người chơi tự do chọn mắt xanh lam, đỏ ngọc, hay hổ phách mà không làm đổi màu lòng trắng (sclera) hay viền mi mắt.

---

## 3. Tích Hợp Godot Engine Runtime: Shader Tô Màu Động

Trong Godot Engine, cấu trúc một nhân vật module hóa được thiết lập như sau:

```
CharacterBody2D (Player)
  ├── AnimatedSprite2D (BaseBody) -> Shader: character_modular_tint.gdshader (Tint: Da người)
  ├── AnimatedSprite2D (Clothing) -> Shader: character_modular_tint.gdshader (Tint: Xanh Navy)
  ├── AnimatedSprite2D (Hair)     -> Shader: character_modular_tint.gdshader (Tint: Vàng Kim)
  └── AnimatedSprite2D (Eyes)     -> Shader: character_modular_tint.gdshader (Tint: Ngọc Lục Bảo)
```

Tất cả các `AnimatedSprite2D` dùng chung một bộ `SpriteFrames` hoặc đồng bộ khung hình cử động qua thuộc tính `frame` và `animation`.

### Mã Shader Tích Hợp (`character_modular_tint.gdshader`):
Vị trí template: `catalog/game-studio/templates/shaders/character_modular_tint.gdshader`

```glsl
shader_type canvas_item;

uniform vec4 tint_color : source_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform float tint_intensity : hint_range(0.0, 1.0, 0.05) = 1.0;
uniform bool preserve_specular = true;
uniform float specular_threshold : hint_range(0.7, 1.0, 0.02) = 0.92;

void fragment() {
    vec4 tex_color = texture(TEXTURE, UV);
    if (tex_color.a < 0.01) {
        COLOR = vec4(0.0);
    } else {
        float luminance = dot(tex_color.rgb, vec3(0.299, 0.587, 0.114));
        // Bảo tồn đốm sáng trắng phản chiếu (specular highlight trên mắt hoặc giáp sắt)
        if (preserve_specular && luminance >= specular_threshold) {
            COLOR = tex_color;
        } else {
            vec3 blended = mix(tex_color.rgb, tint_color.rgb * luminance, tint_intensity);
            COLOR = vec4(clamp(blended, 0.0, 1.0), tex_color.a * tint_color.a);
        }
    }
}
```

---

## 4. Lợi Ích Vượt Trội

1. **Tiết kiệm 90% dung lượng VRAM**: 1 bộ hoạt ảnh duy nhất có thể biểu diễn 1,000 NPC khác nhau trong thành phố.
2. **Khả năng tùy biến vô hạn (Character Customization)**: Người chơi tự chọn màu da, màu mắt, kiểu tóc, áo giáp trong menu tạo nhân vật.
3. **Độ ổn định tuyệt đối**: Không bao giờ xảy ra lỗi tóc bay lệch khỏi đầu khi chạy, vì tất cả các layer đều được cắt khớp pixel 1-1 với khung hình Base.
