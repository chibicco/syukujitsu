# Syukujitsu

[![Test](https://github.com/chibicco/syukujitsu/actions/workflows/test.yml/badge.svg)](https://github.com/chibicco/syukujitsu/actions/workflows/test.yml)
[![Gem Version](https://badge.fury.io/rb/syukujitsu.svg)](https://rubygems.org/gems/syukujitsu)

[内閣府「国民の祝日」](https://www8.cao.go.jp/chosei/shukujitsu/gaiyou.html)のデータを提供する Ruby gem です。
内閣府が公開する CSV を正とし、1955年〜の祝日データを `Enumerable` なインターフェースで扱えます。
土日などの曜日判定は含まず、「国民の祝日」のみを対象としています。

## インストール

```ruby
# Gemfile
gem "syukujitsu"
```

```sh
bundle install
```

## 使い方

```ruby
require "syukujitsu"

# 祝日かどうか
Syukujitsu.holiday?(Date.new(2025, 1, 1))  #=> true
Syukujitsu.holiday?(Date.new(2025, 1, 2))  #=> false

# 祝日名を取得
Syukujitsu.name(Date.new(2025, 1, 1))  #=> "元日"

# Entity オブジェクトを取得
entity = Syukujitsu.on(Date.new(2025, 1, 1))
entity.date  #=> #<Date: 2025-01-01>
entity.name  #=> "元日"

# 期間内の祝日を取得
Syukujitsu.between(Date.new(2025, 1, 1), Date.new(2025, 3, 31))
#=> [#<Syukujitsu::Entity 2025-01-01 元日>, #<Syukujitsu::Entity 2025-01-13 成人の日>, ...]

# Enumerable
Syukujitsu.select { |e| e.date.year == 2025 }
Syukujitsu.count
```

`Date`、`DateTime`、`Time` いずれも引数に渡せます。

### Date 拡張

`core_ext` を require すると `Date` にメソッドが生えます。

```ruby
require "syukujitsu/core_ext"

Date.new(2025, 1, 1).holiday?      #=> true
Date.new(2025, 1, 1).holiday_name  #=> "元日"
```

グローバルな monkey patch を避けたい場合は、Refinement 版も使えます。

```ruby
require "syukujitsu/refinements/date_methods"

class MyApp
  using Syukujitsu::Refinements::DateMethods

  def greet(date)
    if date.holiday?
      "#{date.holiday_name}です"
    else
      "平日です"
    end
  end
end
```

## CSV の更新

内閣府の最新データで `holidays.csv` を更新できます。

```sh
bundle exec syukujitsu update
```

リポジトリでは GitHub Actions により毎週土曜に差分を検知し、更新がある場合は自動で PR が作成されます。

## API

| メソッド | 戻り値 | 説明 |
|---|---|---|
| `Syukujitsu.holiday?(date)` | `Boolean` | 祝日かどうか |
| `Syukujitsu.on(date)` | `Entity` / `nil` | 祝日の Entity を返す |
| `Syukujitsu.name(date)` | `String` / `nil` | 祝日名を返す |
| `Syukujitsu.between(start, end)` | `Array<Entity>` | 期間内の祝日を返す |
| `Syukujitsu.each` | `Enumerator` | 全祝日をイテレート |

## データソース

[内閣府「国民の祝日」CSV](https://www8.cao.go.jp/chosei/shukujitsu/syukujitsu.csv)

## ライセンス

[MIT License](LICENSE.txt)
