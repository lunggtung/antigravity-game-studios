# Visual Entity & Screen Inventory (Bảng Danh Mục Thực Thể & Màn Hình Game)

> Dự án: [Tên Dự Án]
> Ngày lập: [YYYY-MM-DD]
> Trạng thái tổng: [N] Needed | [N] In Progress | [N] Done

## 1. Characters & Creatures (Nhân Vật & Sinh Vật)

| Asset ID | Tên Thực Thể | Vai Trò / Type | Kích Thước Chuẩn | Quy Cách Hoạt Ảnh | Trạng Thái | File Spec Chi Tiết |
|---|---|---|---|---|---|---|
| ASSET-001 | [Tên nhân vật chính] | Player / Protagonist | 256×256 px | Idle, Walk 4 hướng, Attack, Hurt | Needed | `specs/assets/characters-spec.md` |
| ASSET-002 | [Tên NPC / Quái vật] | NPC / Enemy | 256×256 px | Idle, Walk, Action | Needed | `specs/assets/characters-spec.md` |

## 2. Environment Props & Furniture (Đồ Nội Thất & Phụ Kiện Môi Trường)

| Asset ID | Tên Vật Thể | Phân Loại | Kích Thước Ô Lưới | Tương Quan Nhân Vật | Trạng Thái |
|---|---|---|---|---|---|
| ASSET-101 | [Quầy bar / Bàn làm việc] | Compact / Wide Prop | 128×64 px | Cao ngang ngực nhân vật (60px) | Needed |
| ASSET-102 | [Bàn ghế / Đèn đường] | Y-sorted Prop | 64×64 px | Thấp hơn nhân vật, nhân vật đi trước/sau | Needed |

## 3. UI Screens & HUD Elements (Màn Hình & Giao Diện)

| Asset ID | Tên Giao Diện | Phân Loại | Độ Phân Giải | Mô Tả | Trạng Thái |
|---|---|---|---|---|---|
| ASSET-201 | Main Menu | Screen | 1920×1080 | Start, Settings, Quit, Background Art | Needed |
| ASSET-202 | Player HUD | In-Game HUD | Canvas Scaled | Thanh máu, Mana, Tiền xu, Túi đồ | Needed |
