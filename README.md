# Unexplored Music

[![Image from Gyazo](https://i.gyazo.com/b1c0ad6ef5a1112e4e44d95622f03a4f.png)](https://gyazo.com/b1c0ad6ef5a1112e4e44d95622f03a4f)

<p style="display: inline">
<img src="https://img.shields.io/badge/-Ruby%203.2.2-CC342D.svg?logo=ruby&style=plastic">
<img src="https://img.shields.io/badge/-Ruby%20on%20Rails%207.1.3-CC0000.svg?logo=rails&style=plastic">
<img src="https://img.shields.io/badge/-TailwindCSS-06B6D4.svg?logo=tailwindcss&style=plastic">
<img src="https://img.shields.io/badge/-Javascript-F7DF1E.svg?logo=javascript&style=plastic">
<img src="https://img.shields.io/badge/-Postgresql-336791.svg?logo=postgresql&style=plastic">
<img src="https://img.shields.io/badge/-Docker-1488C6.svg?logo=docker&style=plastic">
</p>

## サービス概要

Unexplored Music は、ユーザーの嗜好をもとに まだユーザーが知らないジャンルを推定し 新鮮な音楽体験を提供する、AI を使った音楽レコメンドサービスです。

## 想定されるユーザー層

・未知の音楽ジャンルを体験してみたい全ての人

## サービスコンセプト

音楽レコメンドサービスが現在様々なものが充実していますが、
ユーザーの嗜好に沿って類似のものを提示する、という方向性で作られたものが多く、
新奇性の提供にフォーカスしたものは少ないと感じていました。

自分自身は、それまでの自らの嗜好から離れた音楽を聴いてみるのが好きで、
そのような体験がより簡単に出来る方法はないかと以前から考えており、
Unexplored Music というサービス名での制作を決めました。  
新奇な音楽体験をより身近に感じられるための一助になれば幸いです。

## 実現の方法

ユーザーが作成したリストに、任意のアーティストを登録すると、
Spotify API によって、登録されたアーティストから音楽ジャンルの文字列データ取得がリストごとに行われます。

取得されたジャンルのデータを整形し、OpenAI API による自然言語処理を使ったロジックにより、レコメンドすべきジャンル名を推定してもらい、処理がしやすい形式でジャンル名の文字列のデータを出力してもらいます。

そのデータを使って再び Spotify API にリクエストし、そこで取得した楽曲群にユーザーに提供すべき楽曲を選定するロジックで処理を行い、得られた結果を提供します。

## 使用 API

- Spotify API
- OpenAI API

## 実装予定機能

### MVP

- 会員登録
- ログイン
- アーティストのリストの作成
  - 登録されたリストの一覧
  - 登録されたリストの編集、削除
- リストへのアーティストの登録
  - 登録されたアーティストの一覧
  - 登録されたアーティストの編集、削除
- リストに基づいた新規ジャンルからのレコメンド機能：OpenAI API, Spotify API
- 楽曲の再生：Spotify API

### その後の機能

- リストに含まれるジャンルをまとめて表示する機能：Spotify API
- 他ユーザーが作ったリストの閲覧
  - 他ユーザーが作ったリストのブックマーク機能
  - 他ユーザーが作ったリストをレコメンドに使うことができる機能：OpenAI API, Spotify API
- レコメンド内容の SNS への投稿
- レコメンド楽曲のレーティング機能
  - レーティングの一覧
  - レーティングの詳細

### figma

https://www.figma.com/file/0AWuFuZdMZT0cTyp60BJGz/PF%E9%81%B7%E7%A7%BB%E5%9B%B3?type=design&mode=design&t=ijRtyQ2gDgpqgmb2-1

### ER 図

[![Image from Gyazo](https://i.gyazo.com/924895ab479a9d6fbbed31984408796a.png)](https://gyazo.com/924895ab479a9d6fbbed31984408796a)
