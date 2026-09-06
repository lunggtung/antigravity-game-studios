# Character Visual Specifications (Đặc Tả Chi Tiết Nhân Vật Chuẩn Pixel)

> Dự án: [Tên Dự Án]
> Tiêu chuẩn độ phân giải nhân vật: 256×256 px (Extra-Large Pixel Character) hoặc 32×32 px (Chibi Retro)
> Bảng màu định chuẩn (Palette): [Đường dẫn file palette hoặc danh sách mã hex]

---

## ASSET-001 — [Tên Nhân Vật]

### 1. Thông Số Kỹ Thuật (Technical Constraints)
- **Kích thước ô (Cell Dimensions)**: 256×256 px (hoặc kích thước chuẩn dự án)
- **Định dạng file**: PNG trong suốt (RGBA 32-bit)
- **Góc nhìn (Perspective)**: Top-Down 3/4 Oblique (hoặc Side-View)
- **Trục tiếp đất (Anchor / Pivot Point)**: Chân chạm đất `bottom-center` (ví dụ: x=128, y=240)
- **Scale Budget**: Chiều cao thân người chiếm 65% - 70% chiều cao ô ô để chừa lề an toàn (safe margin).

### 2. Mô Tả Mỹ Thuật & Bảng Màu (Art Description & Color System)
- **Ngoại hình**: [Mô tả chi tiết kiểu tóc, nét mặt, trang phục, vũ khí]
- **Màu chủ đạo**:
  - Da: `#...`
  - Tóc: `#...`
  - Trang phục chính: `#...`
  - Điểm nhấn (Accent): `#...`

### 3. Quy Cách Hoạt Ảnh (Animation Clips)
| Clip Name | Số Khung Hình | Tốc Độ (FPS) | Lặp (Loop) | Hành Động |
|---|---|---|---|---|
| `idle` | 4 frames (`2x2`) | 6 fps | Có | Thở nhấp nhô nhẹ tại chỗ, giữ cố định chân |
| `walk_down` | 4 frames (`2x2`) | 8 fps | Có | Bước đi xuống dưới màn hình |
| `walk_side` | 4 frames (`2x2`) | 8 fps | Có | Bước đi ngang sang phải (lật trái bằng code) |
| `walk_up` | 4 frames (`2x2`) | 8 fps | Có | Bước đi hướng lên |
| `action` | 4-6 frames | 10 fps | Không | Vung vũ khí / Pha chế / Tương tác |

### 4. Prompt Mẫu Chuẩn Cho Tool Sinh Asset (PixelLab / AI Engine)
```text
[Prompt tối ưu hóa chỉ định rõ góc nhìn, kích thước, nền đơn sắc #FF00FF hoặc #00FF00, không đổ bóng sàn, không viền thừa]
```
