# うんこの気持ち - UnkoFeelings
5日間で iOS アプリを作るトレーニングプロジェクトです

<img width="256" src="https://user-images.githubusercontent.com/43261614/45923809-039e3900-bf2b-11e8-8602-c3def71a8185.png" /> <img width="256" src="https://user-images.githubusercontent.com/43261614/45923812-06009300-bf2b-11e8-9083-48168c7357df.png" /> <img width="300" src="https://user-images.githubusercontent.com/43261614/45923813-09941a00-bf2b-11e8-82e0-dc3c8ed780ac.gif" /> 

# 概要
iOS アプリ開発のお勉強のためにアプリを５日で作る。

## アプリ内容
- うんこの気持ちを記録できるアプリ
- うんこをしたときに記録
- うんこの気持ちを入力する画面と、うんこの気持ちのログを見れる画面を作る
- Repository:  [GitHub - yutoji/UnkoFeelings](https://github.com/yutoji/UnkoFeelings)

## 目的
- AutoLayout の練習
- UITableView の練習
- UITableViewCell 内でちょっとしたアニメーションをさせる
    - 本来 stateless な UITableViewCell に、状態管理をもつ ViewModel を外挿して状態管理
- きちんと動くものを一日サイクルで作る
- デザインは特にこだわらない
- 優先順位付けられたタスクリストを利用する

## 気をつけること
- クオリティが低くてもいいから、ちゃんと動くものを作る
- ５日で完成させる

# 記録

## Day 1
- Main Storyboard に TabView を生成し、 InputViewController、 LogViewController の Storyboard を作ってリンクする
- うんこの気持ちを記録する InputViewController の入力画面の作成
- うんこの気持ちデータモデルタイプを enum で定義
- うんこの気持ちデータモデルを struct で作る
- ローカルデータ書き込みインタフェースの作成

## Day 2
- データモデルと InputViewController と書き込みインタフェースとの結合

## Day 3
- ログ画面の TableViewCell の xib と swift を作成
- ログ画面の LogViewController を実装
    - ViewModel を stateful にする必要があっていろいろな改修の必要性を発見し、それに時間を費やすことになる

## Day 4
- ログ画面の LogViewController とうんこデータの結合
    - うんこデータのバリューオブジェクトのエンティティクラスを作ったりファクトリーを作りid重複チェックをしたり
- ローカルデータ書き込みクラスの実装
- ログ画面のテーブルセルビューのブラッシュアップ

## Day5
- タブバーアイコンの設定
- 記録画面にピッカービューを追加する
- ログ画面のバルーンのタップ時のアクション設定
- ログ画面の TableViewCell にアニメーション機能

## 未実装
- キーボード外をタップでキーボードを閉じる処理

# 総括
- できたこと
  - 矛盾なし AutoLayout
  - MVVM パターンとそのユニットテスト
  - UITableViewCell に状態管理のモデルを外挿してアニメーションを実現
  - クリーンアーキテクチャを意識して、デバイス依存部分をプロトコルで隠蔽
- 時間がかかって困ったこと
  - 当初、タイムラインデータを ValueObject として定義していたが、途中から Entity にする必要があり、リファクタリングに時間がかかった
  - UITableViewCell 内でアニメーションを実現するための方法を、探しながら実装したため、時間がかかった
- できなかったこと
  - UITests
  - キーボードをしまう処理
- 謎だったこと
  - うんこの気持ちを書いているのか、うんこをした人の気持ちを書いているのか、わからなくなった
