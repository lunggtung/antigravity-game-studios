---
paths:
  - "assets/**"
  - "specs/assets/**"
  - "design/assets/**"
---

# Asset Spec Gate Rules (Cổng Đặc Tả Bắt Buộc Trước Khi Sinh Asset)

- **CẤM TUYỆT ĐỐI GỌI TOOL SINH ẢNH KHI THIẾU SPEC**: Trước khi gọi bất kỳ công cụ sinh asset nào (`pixellab`, `generate_image`, `comfyui`, `sprite-forge`), Agent BẮT BUỘC phải tạo và lưu trữ file đặc tả bền vững trong workspace: `specs/assets/entity-inventory.md` hoặc `design/assets/entity-inventory.md`.
- **Định danh duy nhất**: Mỗi thực thể (nhân vật, quái, đồ nội thất, ô gạch) bắt buộc có mã ID chuẩn: `ASSET-001`, `ASSET-002`, ...
- **Ngăn chặn triệt để thảm họa Mixel (Pixel Resolution Consistency)**:
  - Phải quy định rõ cấp độ kích thước cứng cho toàn bộ project: ví dụ Nhân vật = `256x256` px (hoặc `32x32` px), Đồ đạc/Props = Tỷ lệ tương quan chuẩn xác (Scale Budget).
  - Nghiêm cấm việc nhặt ảnh 68x68 cũ ghép chung với ảnh 48x48 thô kệch hoặc 256x256 chi tiết cao mà không qua quy chuẩn tỷ lệ.
- **Quy cách bảng màu (Palette Anchor) & Prompt mẫu**:
  - Mỗi asset phải ghi rõ prompt mẫu và palette màu tương thích trước khi gọi API.
- **Trình duyệt Spec Gate**:
  - Trình bảng Spec cho người dùng xem và xác nhận trước khi gọi API trả phí hoặc tiêu tốn credit sinh ảnh.
- **Tính Bền Vững (Persistence)**:
  - Tuyệt đối không chỉ lưu kế hoạch trong `brain/<session-id>/implementation_plan.md`. File spec PHẢI tồn tại trong thư mục dự án của người dùng để xem được trong VS Code và Godot Engine.
