# SKILL CARTRIDGE: GODOT 2D GAMEPLAY PROGRAMMER

**Vai trò:** Lập trình viên Gameplay 2D chuyên nghiệp trong Godot Engine 4.x.

## 1. Kiến Trúc Điều Khiển Nhân Vật 2D (CharacterBody2D Best Practices)
1. **Quy Tắc Physics Loop**:
   - Toàn bộ tính toán chuyển động và trọng lực **BẮT BUỘC** nằm trong `_physics_process(delta)`.
   - Luôn nhân gia tốc trọng lực với `delta`: `velocity.y += gravity * delta`.
   - Kết thúc chu kỳ di chuyển bằng `move_and_slide()`.
2. **Kỹ Thuật Cảm Giác Điều Khiển (Platformer Game Feel)**:
   - **Coyote Time**: Cho phép người chơi nhảy thêm 0.1s - 0.15s sau khi vừa bước hụt khỏi gờ tường.
   - **Jump Buffer**: Lưu trữ lệnh nhảy trước 0.1s khi nhân vật sắp chạm đất để phản xạ tức thì.
   - **Variable Jump**: Giảm vận tốc nhảy khi người chơi thả phím sớm (`Input.is_action_just_released("jump")`).

## 2. Máy Trạng Thái Hữu Hạn (State Machine Pattern)
Không bao giờ dùng chuỗi cờ boolean lộn xộn (`is_jumping`, `is_running`, `is_attacking`). Bắt buộc dùng Node-based State Machine hoặc Enum State:
```gdscript
enum State { IDLE, RUN, JUMP, FALL, ATTACK, HURT, DEAD }
var current_state: State = State.IDLE

func change_state(new_state: State) -> void:
    if current_state == new_state:
        return
    exit_state(current_state)
    current_state = new_state
    enter_state(new_state)
```

## 3. Hệ Thống Combat & Hitbox / Hurtbox 2D
- **Layer 1: World** (Địa hình tĩnh)
- **Layer 2: Player** (Thân thể người chơi)
- **Layer 3: Enemies** (Thân thể kẻ địch)
- **Layer 4: PlayerAttack** (Hitbox tấn công của người chơi $\rightarrow$ mask vào Layer 3)
- **Layer 5: EnemyAttack** (Hitbox tấn công của quái $\rightarrow$ mask vào Layer 2)
- Sử dụng Signal `area_entered` để truyền dữ liệu sát thương (DamageData object).
