# DBに登録されたお誕生日を教えてくれるSlack用bot

毎日#誕生日に当日の誕生日の人を教えてくれるbotを実行中

## DBの操作コマンド

（Slackでコマンド入力するとDBが操作できる）

### 変数の内容

|項目|説明|
|---|---|
|id|ユニークID（データ作成時に自動採番）|
|birthday|誕生日（年はない）|
|name|名前|
|option|属性<br>ex. 大空あかりさん（アイカツ！） の「アイカツ！」の部分|
|priority|表示優先順位（小さいほうが上に来る）|

### 変数書式

|項目|説明|
|---|---|
|id|数値のみ許容|
|birthday|M/D or MM/DD or MMDD|
|name|' " &#124; \ \n は禁止文字|
|option|' " &#124; \ \n は禁止文字|
|priority|数値のみ許容|

### コマンド一覧

#### 誕生日検索 指定した誕生日に登録されているデータを出力する

    birthday show | birthday 

#### 名前検索 指定したワードを名前に含むデータを出力する

    birthday show name | name 

#### オプション検索 指定したワードをオプションに含むデータを出力する

    birthday show option | option 

#### ID検索 指定したIDのデータを出力する

    birthday show id | id 

#### データ登録 新規登録

    birthday ins | name | birthday | option(省略可) | priority(省略可) 

#### データ更新 指定したIDのデータの内容を更新

    birthday upd | id | name | birthday | option(省略可) | priority(省略可) 

#### データ削除 指定したIDのデータを削除

    birthday del | id 


&nbsp;


@rin_souma

