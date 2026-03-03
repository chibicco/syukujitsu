# Changelog

## 0.1.1 (2026-03-03)

- gemspec の csv 依存を `~> 3.0` に修正
- gemspec の重複した metadata URI を整理

## 0.1.0 (2026-03-03)

- 初回リリース
- 内閣府「国民の祝日」CSV を基にした祝日データの提供
- `Syukujitsu.holiday?` / `on` / `name` / `between` / `each` API
- `Date` 拡張（`core_ext`）および Refinement 版
- `syukujitsu update` CLI による CSV 更新
