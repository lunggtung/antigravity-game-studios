# Giao Tiếp & An Toàn Cơ Bản
- trao đổi với tôi bằng tiếng việt
- cuối mỗi câu trả lời đều phải có icon này: 🤖👍
- mặc định chỉ sử dụng cmd để chạy lệnh
- tuyệt đối KHÔNG sử dụng các script thay thế chuỗi cứng (như Regex) để sửa đổi mã nguồn hàng loạt.

# Multi-Agent OS (Hệ Điều Hành Đa Agent Thống Nhất - Duy Nhất)
Toàn bộ hệ thống kỹ năng, quy trình lập trình, phát triển phần mềm, studio game và kiểm thử tự hành được hợp nhất và quản trị duy nhất bởi **Multi-Agent OS**:
@C:\Users\11244077\.gemini\config\plugins\multi-agent-os\rules\00-global-contract.md

## Các Chế Độ Vận Hành (Operating Modes):
1. **Goal Mode (`goal-mode`)**: Kích hoạt khi người dùng gọi `/goal` hoặc bài toán lớn S3/S4 cần checkpointing, tự hành qua đêm và phục hồi crash.
2. **Software Team Mode (`software-team-mode`)**: Kích hoạt khi xây dựng dự án Fullstack/SaaS (Product BA -> Architect -> Fullstack Coders -> QA).
3. **Game Studio Mode (`game-studio-mode`)**: Kích hoạt khi phát triển Game Godot (GDD, 2D Pixel / 3D glTF, Master Asset Forge, Godot MCP, Bot Playtester).
4. **Tactical TDD Mode (`tactical-tdd-mode`)**: Mặc định cho lập trình hàng ngày, Red-Green-Refactor, bisection debugging.

## Hai Cổng Bảo Vệ Đầu - Cuối Bắt Buộc (Universal Quality Bookends):
- **Cả Spec lẫn Red-Team Audit KHÔNG PHẢI là Mode rời rạc**: Chúng là 2 cổng bảo vệ bắt buộc của TẤT CẢ các chế độ trên.
- **CỔNG ĐẦU (Gate 0: Spec-First Gate)**:
  - Bắt buộc tạo thư mục `specs/` bền vững trong workspace dự án (`specs/functional-spec.md` cho phần mềm, `specs/assets/entity-inventory.md` cho game).
  - CẤM VIẾT CODE hoặc gọi tool sinh ảnh (`pixellab`, `generate_image`, `comfyui`) khi chưa có Spec và chưa duyệt kích thước pixel/palette.
- **CỔNG CUỐI (Gate 3: Red-Team Audit & QA Gate)**:
  - Bắt buộc kiểm toán độc lập phản biện lỗ hổng (The Saboteur, Security Red-Team, Bot Playtester, Compiler Exit Code 0).
  - CẤM TỰ TUYÊN BỐ "HOÀN THÀNH" nếu chưa có bằng chứng vượt qua Gate 3.

## Cơ Chế Nạp Kén Động (Dynamic Cartridge Dispatch Map):
Khi thực hiện các tác vụ bên dưới, Agent **BẮT BUỘC** gọi `view_file` nạp file SKILL hoặc Cartridge tương ứng từ `catalog/` trước khi viết code hoặc gọi tool:

### 1. Game Studio - Đồ Họa & Asset Pipeline (`catalog/game-studio/skills/`):
- **Tạo Sprite 2D / Hoạt ảnh / Lưới Chroma**: `catalog/game-studio/skills/sprite-forge/SKILL.md`
- **Bản đồ phân tầng RPG / TileSet / Props**: `catalog/game-studio/skills/map-forge/SKILL.md`
- **Khử rung tiếp đất / Review Sprite Viewer**: `catalog/game-studio/skills/sprite-align-polish/SKILL.md`
- **Nhân vật đa tầng / Shader Tinting**: `catalog/game-studio/skills/character-layer-forge/SKILL.md`
- **Đặc tả tài nguyên / Entity Inventory (Gate 0)**: `catalog/game-studio/skills/asset-spec/SKILL.md`
- **Kiểm toán chất lượng Asset thực tế**: `catalog/game-studio/skills/asset-audit/SKILL.md`
- **Sổ tay mỹ thuật (Art Bible)**: `catalog/game-studio/skills/art-bible/SKILL.md`

### 2. Game Studio - Thiết Kế Game & Kỹ Thuật Godot:
- **Thiết kế Game / GDD / Vòng lặp Gameplay**: `catalog/game-studio/skills/design-system/SKILL.md`
- **Cân bằng kinh tế & Chỉ số (Balance)**: `catalog/game-studio/skills/balance-check/SKILL.md`
- **Hệ thống chiến đấu (Combat System)**: `catalog/game-studio/skills/team-combat/SKILL.md`
- **Thiết kế màn chơi & Phụ kiện (Level Design)**: `catalog/game-studio/skills/team-level/SKILL.md`
- **Giao diện người dùng Game (Game UI/HUD)**: `catalog/game-studio/skills/team-ui/SKILL.md`
- **Âm thanh & Hiệu ứng (Audio SFX/BGM)**: `catalog/game-studio/skills/team-audio/SKILL.md`
- **Đánh bóng trải nghiệm & Juice (Polish)**: `catalog/game-studio/skills/team-polish/SKILL.md`
- **Lát cắt dọc hoàn chỉnh (Vertical Slice)**: `catalog/game-studio/skills/vertical-slice/SKILL.md`
- **Kiểm thử tự hành & QA Game (Bot Playtest)**: `catalog/game-studio/skills/team-qa/SKILL.md`

### 3. Software Team - Phần Mềm & SaaS (`catalog/software/`):
- **Product BA / User Stories / Acceptance Criteria**: `catalog/software/product/product-ba.md`
- **System Architecture / API Contracts / DB Schema**: `catalog/software/architecture/system-architect.md`
- **Fullstack Coding / TDD Implementation**: `catalog/software/engineering/fullstack-coder.md`
- **QA & Testing Matrix**: `catalog/software/qa/qa-engineer.md`
- **Security Audit & Code Hardening**: `catalog/software/security/security-auditor.md`

Tất cả kén kỹ năng chuyên sâu được nạp động từ `catalog/` theo bản đồ trên, không làm tràn ngập ngữ cảnh toàn cục.





