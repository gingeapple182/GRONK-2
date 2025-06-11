# GRONK-2: Electric boogaloo

## Overview
GRONK 2 is a personal project, serving as a spiritual successor to my first-year uni project.  
The goal is to collect all the coins and reach the end without dying. While the core mechanics are currently focussed on movement, I plan to introduce light combat elements in the future.

---

## Development Plan

### 1. Player System

**Core Structure:**
- Root: `CharacterBody2D`
- Children: `AnimatedSprite2D`, `CollisionShape2D`, `Timer`, `Audio` (Jump, Hurt, etc.), `StompArea` (Area2D + CollisionShape2D)

**State Machine:**
- Implement a state machine for player states: Idle, Run, Jump, Fall, Hurt, Dead, etc.
- Use an enum or string for state tracking.
- Handle transitions and logic in a clean, modular way.

**Signals:**
- Define and emit signals for key events: `jumped`, `hurt`, `died`, `collected_coin`, `stomped_enemy`, etc.
- Connect signals to UI, audio, and effects.

**Core Abilities:**
- Running, jumping, falling, stomping enemies.
- Taking damage and temporary invincibility.
- Collecting coins and interacting with level objects.

**Possible Additions:**
- Wall jumping, dashing, double jump, power-ups.
- Melee or ranged attacks (for future combat).
- Health upgrades, temporary shields, or special abilities.
- Animation and sound polish for all actions.

---

### 2. Enemy System

**Base Enemy Structure:**
- Root: `Area2D` (or inherited from a base enemy scene)
- Children: `AnimatedSprite2D`, `CollisionShape2D`, `Timer`, `Audio`, etc.

**Base Enemy Script:**
- Shared logic: health, damage, movement stubs, signals for `stomped`, `died`, etc.
- Exported variables for customization: health, speed, damage, stomp behavior, etc.

**Enemy State Machine:**
- Optional: Use a state variable for enemy states (Idle, Patrol, Attack, Dead, etc.)
- Cleanly separate logic for each state.

**Signals:**
- Emit signals for `died`, `stomped`, `player_hit`, etc.
- Allow level manager or UI to react to enemy events.

**Enemy Types (Examples):**
- **Basic Walker:** Moves back and forth, dies when stomped.
- **Slime:** Bounces player high when stomped, does not die.
- **Flying Enemy:** Patrols in the air, can be stomped or avoided.
- **Shooter:** Fires projectiles at the player.
- **Boss:** Multiple phases, unique attacks, requires multiple hits.

**Possible Additions:**
- Enemies with shields, armor, or special resistances.
- Enemies that split into smaller ones when defeated.
- Environmental hazards (spikes, pits, moving platforms).

---

### 3. Level & Game Systems

**Level Structure:**
- Use scenes for each level.
- Place coins, enemies, and hazards as needed.
- Add checkpoints and level goals.

**UI & Feedback:**
- Health display, coin counter, pause menu.
- Visual and audio feedback for all player and enemy actions.

**Signals & Managers:**
- Use a LevelManager or GameManager node to handle global events (level complete, player death, etc.).
- Connect signals from player and enemies to managers and UI.

---

### 4. Art, Audio, and Polish

**Assets:**
- Use custom sprites for player, enemies, and UI.
- Use open-source tilesets for levels (e.g., Kenney).

**Polish:**
- Add particle effects, camera shake, and sound effects for actions.
- Smooth transitions and animations for all states.

---

## To-do
- [ ] Add background to title cards
- [ ] Design new Enemy sprites
- [ ] Update player spritesheet for more animations
- [ ] Develop light combat features
- [ ] Add more levels
- [ ] (Optimisation) Decide on singular floater vs multiple .tscn files

---

## Supporting materials

Using pixel art sprite sheets for levels from [Kenney](https://kenney.nl)

