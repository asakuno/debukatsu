## サービス概要
忙しく食事の時間も憚られる現代社会人に、コンビニ商品を検索して、安く多くのカロリーを摂取することを主とした健康管理サービスです。

## メインのターゲットユーザー
- お金がない学生や社会人
- 食事の味を度外視して、多くのカロリーを摂取したい人
- 時間に追われる現代社会人

## ユーザーが抱える課題
- 現代人は摂取カロリーが年々減少しており、エネルギー不足に陥っている。
- お金はないが自炊は面倒でコンビニ飯で済ませてしまい、出費がかさんでしまう。

## 解決方法
- あらかじめ自分の食べたいものを選んでおき、その中から一番安く多くのカロリーが摂れる食品を算出するアプリを提供する。

## 実装予定の機能（以下の例は実際のアプリの機能から一部省略しています）
- 未ログインユーザー
  - ユーザーがTopページにて下記のコンテンツにアクセスすることができる。
    - 「機能概要」
  - ユーザーが新規登録することができる。
    - 「ユーザーネーム」
    - 「メールアドレス」
    - 「パスワード」
  - ユーザーがログインすることができる。
  - ユーザーがゲストユーザーでログインすることができる。
  
- ログイン済ユーザー
  - マイページ機能
    - ユーザーがマイページにてプロフィールを編集することができる。
      - 「ユーザーネーム」
      - 「メールアドレス」
      - 「アバター画像」
    - ユーザーが１日に必要なカロリーの量を見ることができる。

  - 検索機能
    - ユーザーが検索に入れたい(or除外したい)食品をチェックボックス形式で選ぶことができる。
    - 選ばれた食品をもとに一番安く多くのカロリーを摂ることができる食品を検索できる。

  - 食品一覧
    - ユーザーが商品一覧を確認することができる。
    - ユーザーが商品をクリックするとモーダルが出て商品詳細を確認することができる。

  - お気に入り機能
    - ユーザーが商品一覧からお気に入りを追加することができる。

本リリース
- タグ検索機能
- 別の検索条件の追加
  - 食べやすさで重み付けした係数でカロリー検索
  - 各種栄養成分が一番多い検索
- 栄養素のレーダーチャート化
- 管理ユーザーの追加
- お問い合わせ、プライバシーポリシー、利用規約の追加
- SNS共有機能

## なぜこのサービスを作りたいのか？
- 時間に追われる現代社会人。時間に追われれば追われるほど、私達の心もまた余裕がなくなっていき、食事の時間だけが癒しのひと時になる人も少なくない。しかし、自炊する時間もなく、手軽に済ませることのできるコンビニ飯に逃げ、１日に必要なカロリーが足りていない人も多々いる。現に、数十年前と比較すると私たちの平均摂取カロリーはどんどん低下する一方で、未来に暗雲が立ち込めている。幸せな時間とは何か。食事すら満足ならないこの現代社会に救いはあるのか……  

- そんな中提案するサービスが「安く多くのカロリー」を摂取することのできるこのアプリである。 カロリーとは人生の幸福と言い換えても過言ではない。事実、[京都大学伏木亨教授の研究](https://academic.oup.com/bbb/article/78/3/363/5938303)によると、高カロリーの油脂を多く含む食べ物を食べた直後に、脳内で「ベータ・エンドルフィン」と呼ばれるモルヒネと同じような作用を持つホルモン物質が大量に分泌されることから、カロリー＝幸せということの妥当性がわかる。従って、カロリーを最安で多く取ることのできるサービスによって、社会問題解決への一助、もしくは人々の幸福への寄与となるであろう。このアプリを通して幸せとは何か……今一度考えていただきたい。

- 運動等は度外視しております。
- 現実で起きた不都合、疾患など一切の責任を負いかねます。
- ネタアプリです。

## スケジュール
企画〜技術調査：11/30〆切
README〜ER図作成：12/4 〆切
メイン機能実装：12/5 - 1/16
 β版をRUNTEQ内リリース（MVP）：1/17〆切
 本番リリース：1月末

## 画面遷移図
[Figma]https://www.figma.com/file/FdSL8iq7NFYdhNdAKCz9vu/debukatsu?node-id=0%3A1&t=sFwcyd81H5tvgpQ6-0