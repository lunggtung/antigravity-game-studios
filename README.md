# Antigravity Game Studios

<p align="center">
  <b>Turn Google Antigravity into a full autonomous game development studio.</b><br>
  49 agents. 73 skills. 11 rules. 38 templates. Live Godot MCP and Pixellab MCP integration.<br>
  <i>Adapted from Claude Code Game Studios by Donchitos.</i>
</p>

---

## 🎮 Overview

Building a game solo with AI is powerful — but without structure, it easily degrades into spaghetti code, missing GDDs, hardcoded values, and zero gameplay verification.

**Antigravity Game Studios** solves this by organizing your AI session into a **complete professional game studio hierarchy**:
- **Directors** who protect the creative and technical vision.
- **Department Leads** who own their domains (Design, Art, Audio, QA, Programming).
- **Specialists** who execute hands-on work with engine-specific discipline.
- **Autonomous Live MCPs**: Real Godot node manipulation via `godot-mcp-toolkit` and live pixel art creation via `pixellab`.

---

## 🏛️ Studio Hierarchy (49 Agents)

```
Tier 1 — Directors (Pro)
  creative-director    technical-director    producer

Tier 2 — Department Leads (Inherit)
  game-designer        lead-programmer       art-director
  audio-director       narrative-director    qa-lead
  release-manager      localization-lead

Tier 3 — Specialists (Inherit)
  gameplay-programmer  engine-programmer     ai-programmer
  network-programmer   tools-programmer      ui-programmer
  systems-designer     level-designer        economy-designer
  technical-artist     sound-designer        writer
  world-builder        ux-designer           prototyper
  performance-analyst  devops-engineer       analytics-engineer
  security-engineer    qa-tester             accessibility-specialist
  live-ops-designer    community-manager

Engine Specialists
  Godot 4: godot-specialist, godot-gdscript-specialist, godot-shader-specialist, godot-csharp-specialist, godot-gdextension-specialist
  Unity:   unity-specialist, unity-dots-specialist, unity-shader-specialist, unity-ui-specialist, unity-addressables-specialist
  Unreal:  unreal-specialist, ue-gas-specialist, ue-blueprint-specialist, ue-umg-specialist, ue-replication-specialist
```

---

## 🚀 7-Stage End-to-End Production Pipeline (73 Skills)

1. **Pre-Production Conception**: `/start`, `/brainstorm`, `/setup-engine`, `/map-systems`
2. **System Design & Art Bible**: `/design-system`, `/systems-index`, `/art-bible`, `/asset-spec`, `/ux-design`
3. **Technical Architecture**: `/create-architecture`, `/architecture-decision` (ADRs), `/create-control-manifest`
4. **Vertical Slice Gate**: `/prototype`, `/vertical-slice` (**PROCEED / PIVOT / KILL** decision gate)
5. **Agile Production**: `/create-epics`, `/create-stories`, `/sprint-plan`, `/dev-story`, `/story-done`
6. **Cross-Discipline Orchestration**: `/team-combat`, `/team-narrative`, `/team-ui`, `/team-level`, `/team-audio`, `/team-qa`, `/team-polish`
7. **QA, Balancing & Release**: `/qa-plan`, `/smoke-check`, `/regression-suite`, `/balance-check`, `/playtest-report`, `/release-checklist`

---

## ⚡ Antigravity MCP Superpowers

Unlike Claude Code where agents can only view and generate static text files, **Antigravity Game Studios** connects directly to game engines and graphic tools:

- **Godot MCP Toolkit & Godot AI**:
  - Automatically create and edit Node hierarchies, scenes (`.tscn`), and resources (`.tres`).
  - Run headless Godot game builds and simulate player actions (`input_simulate`).
  - Capture runtime screenshots (`runtime_screenshot`) for autonomous QA playtest validation.
- **Pixellab MCP**:
  - Automatically generate pixel art characters, 8-directional sprites, walk/attack animations, isometric/top-down tilesets, and HUD icons directly into your game's asset folders.

---

## 📦 Installation in Google Antigravity

### Option 1: Global Plugin Installation
Copy the `antigravity-game-studios` folder into your Antigravity plugins directory:
```bash
# Windows
xcopy /E /I /H /Y antigravity-game-studios %USERPROFILE%\.gemini\config\plugins\antigravity-game-studios
```

### Option 2: Project Template
Clone this repository directly as the starting point for any new game project:
```bash
git clone https://github.com/YOUR_USERNAME/antigravity-game-studios.git my-game
cd my-game
```

---

## 📜 License & Acknowledgments

- **Original Project**: [Claude-Code-Game-Studios](https://github.com/Donchitos/Claude-Code-Game-Studios) by **Donchitos** (licensed under MIT).
- **Adapted for Google Antigravity**: Antigravity native tool translation, MCP integrations, and Windows compatibility.
- Licensed under the **MIT License**.
