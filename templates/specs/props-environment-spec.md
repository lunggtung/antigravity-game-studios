# Environment & Props Specifications (Đặc Tả Đồ Đạc & Môi Trường Tương Quan)

> Mục tiêu: Chống triệt để hiện tượng Mixel (lệch tỷ lệ hạt pixel giữa người và vật thể).
> Tỷ lệ nhân vật tham chiếu: [Chiều cao nhân vật tính bằng pixel, ví dụ 180px trong ô 256px].

---

## 1. Bảng Quy Chuẩn Tỷ Lệ Chiều Cao Tương Quan (Height Budget Table)

| Loại Đồ Đạc / Vật Thể | Chiều Cao Tương Đối | Chiều Cao Pixel Thực Tế | Kích Thước Ô Sheet Khuyến Nghị |
|---|---|---|---|
| Ghế đẩu, Thùng gỗ nhỏ, Bụi cỏ | Ngang đầu gối nhân vật | ~35 - 45 px | 64×64 px |
| Bàn uống nước, Quầy bar | Ngang thắt lưng / ngực nhân vật | ~75 - 95 px | 128×128 px hoặc 128×64 px |
| Cột đèn, Tủ sách, Máy pha cà phê | Bằng hoặc cao hơn đầu nhân vật | ~170 - 210 px | 128×256 px hoặc 256×256 px |
| Cây cổ thụ, Cổng đền, Tường thành | Gấp đôi nhân vật | ~300 - 450 px | Cắt đơn lẻ 1x1 hoặc chia dải tile |

---

## 2. Chi Tiết Từng Vật Thể

### ASSET-101 — [Tên Đồ Vật]
- **Kích thước pixel**: [Rộng × Cao]
- **Kiểu hiển thị**: `StaticBody2D` (vật cản) hoặc `Y-Sorted Sprite2D` (đi trước/sau được)
- **Vùng va chạm (Collision Box)**: Chỉ bao quanh chân đế vật thể, không bao trùm toàn bộ ngọn để nhân vật có thể đi sau lưng.
- **Prompt mẫu**:
  ```text
  [Prompt chỉ định rõ góc nhìn tương ứng với nhân vật, vật thể đứng một mình trên nền trong suốt/magenta, bóng phẳng hoặc không bóng]
  ```
