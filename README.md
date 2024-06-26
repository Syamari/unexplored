# Unexplored Music

[![Image from Gyazo](https://i.gyazo.com/1e42ef9bd03654d3609d32639991fd48.png)](https://gyazo.com/1e42ef9bd03654d3609d32639991fd48)

<p style="display: inline">
<img src="https://img.shields.io/badge/-Ruby%203.2.2-CC342D.svg?logo=ruby&style=plastic">
<img src="https://img.shields.io/badge/-Ruby%20on%20Rails%207.1.3-CC0000.svg?logo=rails&style=plastic">
<img src="https://img.shields.io/badge/-TailwindCSS-06B6D4.svg?logo=tailwindcss&style=plastic">
<img src="https://img.shields.io/badge/-Javascript-F7DF1E.svg?logo=javascript&style=plastic">
<img src="https://img.shields.io/badge/-Postgresql-336791.svg?logo=postgresql&style=plastic">
<img src="https://img.shields.io/badge/-Docker-1488C6.svg?logo=docker&style=plastic">
</p>

## URL: https://unexplored-music.com/

## サービス概要

Unexplored Music はユーザーがまだ知らないジャンルを推定して 新鮮な音楽体験を提供する、 AI を使った音楽レコメンドサービスです。

## コンセプト

音楽レコメンドサービスが現在様々なものが充実していますが、
ユーザーの嗜好に沿って類似のものを提示する、という方向性で作られたものが多く、
新奇性の提供にフォーカスしたものは少ないと感じていました。

自分自身は、それまでの自らの嗜好から離れた音楽を聴いてみるのが好きで、
そのような体験がより簡単に出来る方法はないかと以前から考えており、
Unexplored Music の制作を決めました。  
新奇な音楽体験をより身近に感じられるための一助になれば幸いです。

## 想定ユーザー

・未知の音楽ジャンルを体験・開拓したい全ての人

## メイン機能の紹介

|                                                                                                                                                            多機能ホーム画面（マイリストの一覧・作成など）                                                                                                                                                             |
| :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------: |
|                                                                                                                  [![Image from Gyazo](https://i.gyazo.com/677d9c130651f58e9fb0f4f2b03e6822.gif)](https://gyazo.com/677d9c130651f58e9fb0f4f2b03e6822)                                                                                                                  |
| <p align="left"> ユーザーの使用の起点となるページです。デフォルトではマイリストの一覧ページを兼ねており、新規リストの作成もページ遷移をせずにここで行えます。<br>このホーム画面内のコンテンツは、切り替えボタンを押すことで 公開リスト・ブックマーク・レーティング曲の一覧 への切り替えが可能です。<br>また、ユーザーの使用状況に応じて情報や案内が表示されます。</p> |

<br>

|                                                                                   リストの詳細画面（リスト内アーティストの一覧・追加・削除削除 / レコメンド生成 ）                                                                                    |
| :---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------: |
|                                                          [![Image from Gyazo](https://i.gyazo.com/8109b6b233fffbd36b876e58202906c9.gif)](https://gyazo.com/8109b6b233fffbd36b876e58202906c9)                                                          |
| <p align="left">リストに追加されたアーティストの一覧が表示されており、アーティストの新規追加や削除できます。<br>画面下部では、現在リスト内に存在するジャンルの情報の確認もできます。<br>レコメンド楽曲のボタンを押すと、レコメンドが生成されます。<p> |

<br>

|                                                                                                                                         レコメンドの生成                                                                                                                                          |
| :-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------: |
|                                                                                [![Image from Gyazo](https://i.gyazo.com/657a8e08bfec09f2ad9d85911f1badcc.gif)](https://gyazo.com/657a8e08bfec09f2ad9d85911f1badcc)                                                                                |
| <p align="left">リストの詳細画面でレコメンド生成ボタンを押すと、リスト内の情報からジャンルの分析や関連アーティスト情報の取得が行われ、それを元にしてレコメンドが生成・取得されます。<br>レコメンド楽曲が取得されると、再生ページに遷移します。再生ページには楽曲のレーティング機能があります。<p> |

<br>

## 実現の方法

ユーザーが作成したリストに、任意のアーティストを登録すると、
Spotify API によって、登録されたアーティストから関連アーティストと音楽ジャンルと文字列データ取得がリストごとに行われます。

取得されたデータを整形し、OpenAI API による自然言語処理を使ったロジックにより、レコメンドすべきジャンル名を推定してもらい、処理がしやすい形式でジャンル名の文字列のデータを出力してもらいます。

そのデータを使って再び Spotify API にリクエストし、そこで取得した楽曲群にユーザーに提供すべき楽曲を選定するロジックで処理を行い、得られた結果を提供します。

## 使用 API

- Spotify API
- OpenAI API

## アプリの機能

### メイン機能

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

### その他の関連機能

- リストに含まれるジャンルをまとめて表示する機能：Spotify API
- リストのブックマーク機能
- 他ユーザーが作ったリストの閲覧
  - 他ユーザーが作ったリストをレコメンドに使うことができる機能：OpenAI API, Spotify API
- レコメンド内容の SNS への投稿
- レコメンド楽曲のレーティング機能
  - レーティングの一覧
  - レーティングの詳細
  - リプレイ機能

## 使用技術

| カテゴリ           | 技術内容                        |
| ------------------ | ------------------------------- |
| 開発環境           | Docker                          |
| サーバーサイド     | Ruby on Rails 7.1.3・Ruby 3.2.2 |
| フロントエンド     | Ruby on Rails・JavaScript       |
| CSS フレームワーク | Tailwind CSS                    |
| Web API            | OpenAI API・Spotify API         |
| データベース       | PostgreSQL                      |
| インフラ           | Fly.io・Fly Postgres            |
| バージョン管理     | GitHub                          |

<br />

### ER 図

[![Image from Gyazo](https://i.gyazo.com/fd61c3f7ed97078c7da2ae5b7c5b17dc.jpg)](https://gyazo.com/fd61c3f7ed97078c7da2ae5b7c5b17dc)

### 画面遷移図 - Figma

https://www.figma.com/file/0AWuFuZdMZT0cTyp60BJGz/PF%E9%81%B7%E7%A7%BB%E5%9B%B3?type=design&mode=design&t=ijRtyQ2gDgpqgmb2-1
