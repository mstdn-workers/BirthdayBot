# coding: utf-8
cur_path = File.expand_path(File.dirname($0))
require "#{cur_path}/commonValue.rb"
require "#{cur_path}/commonMethod.rb"

class RunCommand
  def initialize
    @db = ManagementDB.new
    @view_message = ""
  end

  #コマンド解析
  def analysisCmd(text)
    list = text.split("|")
    command = list[0].downcase.rstrip
    case command
    when $ins
      return insertData(list)
    when $upd
      return updateData(list)
    when $del
      return deleteData(list)
    when $show
      return showData(list)
    when $show_name
      return showNameData(list)
    when $show_opt
      return showOptionData(list)
    when $show_id
      return showIdData(list)
    when $help
      return showHelp
    else
    end
  end

  #insert処理
  def insertData(list)
    #パラメタの数が足りなければエラー
    if list.length < 3 then
      return showHelp
    end
    name     = list[1].strip
    birthday = list[2].strip

    if list.length >= 4 then
      if list.length >= 5 then
        priority = list[4].strip
      else
        priority = $def_priority
      end
      option = list[3].strip
    else
      priority = $def_priority
      option   = $def_option
    end

    #入力チェック
    if !checkData("0", name, birthday, option, priority) then
        return showHelp
    end

    #日付の編集
    date = editDate(birthday)

    #データ存在チェック
    if @db.checkDataExist(name, option, date) then
      return "同一のデータが既に存在します"
    end

    #データ登録
    data = @db.insertData(name, date, option: option, priority: priority)
    return outputMessage(data, $type_ins)
  end

  #update処理
  def updateData(list)
    #パラメタの数が足りなければエラー
    if list.length < 4 then
      return showHelp
    end

    id       = list[1].strip
    name     = list[2].strip
    birthday = list[3].strip

    if list.length >= 5 then
      if list.length >= 6 then
        priority = list[5].strip
      else
        priority = $def_priority
      end
      option = list[4].strip
    else
      priority = $def_priority
      option   = $def_option
    end

    #入力チェック
    if !checkData(id, name, birthday, option, priority) then
        return showHelp
    end

    #日付の編集
    date = editDate(birthday)

    #データ登録
    data = @db.updateData(id, name, date, option: option, priority: priority)
    return outputMessage(data, $type_ins)
  end

  #delete処理
  def deleteData(list)
    #パラメタの数が足りなければエラー
    if list.length < 2 then
      return showHelp
    end

    id = list[1].strip

    #入力チェック
    if !checkNum(id) then
        @view_message = "IDが不正です\n"
        return false
    end

    #データ削除
    data = @db.deleteData(id)
    return outputMessage(data, $type_del)
  end

  #show処理
  def showData(list)
    #パラメタの数が足りなければエラー
    if list.length < 2 then
      return showHelp
    end

    birthday = list[1].strip

    #日付チェック
    if !checkDate(birthday) then
        @view_message = "誕生日が不正です\n"
        return false
    end

    #日付の編集
    date = editDate(birthday)

    #データ照会
    data = @db.selectDataBirthDay(date)
    return outputListBirthday(data, date)
  end

  #show_name処理
  def showNameData(list)
    #パラメタの数が足りなければエラー
    if list.length < 2 then
      return showHelp
    end

    name = list[1].strip

    #文字チェック
    if !checkText(name) then
        @view_message = "名前が不正です\n"
        return false
    end

    #データ照会
    data = @db.selectDataName(name)
    return outputListName(data, name)

  end

  #show_opt処理
  def showOptionData(list)
    #パラメタの数が足りなければエラー
    if list.length < 2 then
      return showHelp
    end

    option = list[1].strip

    #文字チェック
    if !checkText(option) then
        @view_message = "オプションが不正です\n"
        return false
    end

    #データ照会
    data = @db.selectDataOption(option)
    return outputListName(data, option)

  end

  #show_id処理
  def showIdData(list)
    #パラメタの数が足りなければエラー
    if list.length < 2 then
      return showHelp
    end

    id = list[1].strip

    #数値チェック
    if !checkNum(id) then
        @view_message = "IDが不正です\n"
        return false
    end

    #データ照会
    data = @db.selectDataId(id)
    return outputListName(data, id)
  end

  #ヘルプメッセージ
  def showHelp
    output = @view_message + "ヘルプメッセージ\n"
#    output = output + "```\n"
#    output = output + "変数の内容\n"
#    output = output + "id       : ユニークID（データ作成時に自動採番） \n"
#    output = output + "birthday : 誕生日（年はない） \n"
#    output = output + "name     : 名前 \n"
#    output = output + "option   : 属性 \n"
#    output = output + " 　　　　　ex. 大空あかりさん（アイカツ！） の「アイカツ！」の部分\n"
#    output = output + "priority : 表示優先順位（小さいほうが上に来る） \n\n"
#    output = output + "変数書式\n"
#    output = output + "id       : 数値のみ許容 \n"
#    output = output + "birthday : M/D or MM/DD or MMDD \n"
#    output = output + "name     : \' \" \| \\ \\n は禁止文字 \n"
#    output = output + "option   : \' \" \| \\ \\n は禁止文字 \n"
#    output = output + "priority : 数値のみ許容 \n\n"
#    output = output + "コマンド一覧\n"
#    output = output + "誕生日検索 指定した誕生日に登録されているデータを出力する\n"
#    output = output + "birthday show | birthday \n\n"
#    output = output + "名前検索 指定したワードを名前に含むデータを出力する\n"
#    output = output + "birthday show name | name \n\n"
#    output = output + "オプション検索 指定したワードをオプションに含むデータを出力する\n"
#    output = output + "birthday show option | option \n\n"
#    output = output + "ID検索 指定したIDのデータを出力する\n"
#    output = output + "birthday show id | id \n\n"
#    output = output + "データ登録 新規登録\n"
#    output = output + "birthday ins | name | birthday | option(省略可) | priority(省略可) \n\n"
#    output = output + "データ更新 指定したIDのデータの内容を更新\n"
#    output = output + "birthday upd | id | name | birthday | option(省略可) | priority(省略可) \n\n"
#    output = output + "データ削除 指定したIDのデータを削除\n"
#    output = output + "birthday del | id \n\n"
#    output = output + "```\n"
    output = output + $help_url + "\n"
    return output
  end

  #チェック処理
  def checkData(id, name, birthday, option, priority)
    #数値チェック
    if !checkNum(id) then
        @view_message = "IDが不正です\n"
        return false
    end

    #文字チェック
    if !checkText(name) then
        @view_message = "名前が不正です\n"
        return false
    end

    #日付チェック
    if !checkDate(birthday) then
        @view_message = "誕生日が不正です\n"
        return false
    end

    #文字チェック
    if !checkText(option) then
        @view_message = "オプションが不正です\n"
        return false
    end

    #数値チェック
    if !checkNum(priority) then
        @view_message = "優先順位が不正です\n"
        return false
    end

    return true
  end

  #データ登録メッセージ
  def outputMessage(data, type)
    for row in data do
      id = row['id']
      name = row['name'].force_encoding("UTF-8")
      birthday = row['birthday']
      option   = row['option']
      priority = row['priority']
    end

    #データがない時
    if id.nil? or name.nil? or birthday.nil? or priority.nil? then
      return "データが存在しません"
    end

    month = birthday.slice(0,2)
    day   = birthday.slice(2,2)

    viewName = editViewName(name, option) + "の誕生日を"

    if type == $type_ins then
      output = viewName + month + "月" + day + "日で登録しました\n"
      output = output + "IDは" + id.to_s + "です\n"
      output = output + "優先順位は" + priority.to_s + "です\n"
    elsif type == $type_del then
      output = "ID=" + id.to_s + "\n"
      output = output + viewName + "を削除しました\n"
    end

    return output
  end

  #検索結果メッセージ
  #誕生日検索
  def outputListBirthday(data, date)
    month = date.slice(0,2)
    day   = date.slice(2,2)
    i = 0
    output = month + "月" + day + "日がお誕生日のお友達は\n"
    for row in data do
      id = row['id']
      name = row['name'].force_encoding("UTF-8")
      option   = row['option']
      temp = ljust("・" + editViewName(name, option), 30)
      output = output + temp + "　(ID=" + id.to_s + ")\n"
      i += 1
    end
    if i == 0 then
      output = output + "いませんでした。"
    else
      output = output + "以上、" + i.to_s + "名です。"
    end

    return output
  end

  #検索
  def outputListName(data, name)
    i = 0
    overFlg = false
    oldBirthday = ""
    output = name + "で検索した結果\n"
    for row in data do
      if i >= $search_max then
        i += 1
        overFlg = true
        next
      end
      id = row['id']
      viewName = row['name'].force_encoding("UTF-8")
      birthday = row['birthday']
      option   = row['option']
      priority = row['priority']
      if birthday != oldBirthday then
        month = birthday.slice(0,2)
        day   = birthday.slice(2,2)
        output = output + month + "月" + day + "日\n"
        oldBirthday = birthday
      end
      temp = ljust("・" + editViewName(viewName, option), 30)
      output = output + temp + " (ID=" + id.to_s + "　優先順位=" + priority.to_s + ")\n"
      i += 1
    end
    if i == 0 then
      output = output + "対象者はいませんでした。"
    else
      output = output + "以上、" + i.to_s + "名のデータが存在しました。"
      if overFlg == true then
        output = output + "（" + $search_max.to_s + "件を超える分は表示できません）"
      end
    end

    return output
  end
end
