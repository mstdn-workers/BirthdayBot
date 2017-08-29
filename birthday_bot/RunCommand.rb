# coding: utf-8
require "./commonValue.rb"

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
    when $show_id
      return showIdData(list)
    else
      @view_message = "コマンドが不正です\n"
      return showHelp
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
      priority = list[3].strip
    else
      priority = $def_priority
    end

    #入力チェック
    if !checkData("0", name, birthday, priority) then
        return showHelp
    end

    #日付の編集
    date = editDate(birthday)

    #データ登録
    data = @db.insertData(name, date, priority)
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
      priority = list[4].strip
    else
      priority = $def_priority
    end

    #入力チェック
    if !checkData(id, name, birthday, priority) then
        return showHelp
    end

    #日付の編集
    date = editDate(birthday)

    #データ登録
    data = @db.updateData(id, name, date, priority)
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
  def showHelp
    return @view_message + "ヘルプを出す"
  end


  #チェック処理
  def checkData(id, name, birthday, priority)
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

    #数値チェック
    if !checkNum(priority) then
        @view_message = "優先順位が不正です\n"
        return false
    end

    return true
  end

  #日付編集
  def editDate(date)
    if date.include?("/") then
      pDate = date.split("/")
      return format("%02d", pDate[0]) + format("%02d", pDate[1])
    else
      return date
    end
  end

  #文字チェック
  def checkText(str)
    if str =~ /[\'\"\\\n]/ then
        return false
    else
        return true
    end
  end

  #数値チェック
  def checkNum(str)
    if str =~ /^[0-9]+$/
      return true
    else
      return false
    end
  end

  #日付チェック
  def checkDate(date)
    if date.include?("/") then
      pDate = date.split("/")
      if pDate.length >= 3 then
        return false
      end
      month = pDate[0]
      day   = pDate[1]
    else
      if date !~ /^\d{4}+$/
        return false
      end
      month = date.slice(0,2)
      day   = date.slice(2,2)
    end
    if Date.valid_date?(2000, month.to_i, day.to_i)
      return true
    else
      return false
    end
  end

  #データ登録メッセージ
  def outputMessage(data, type)
    for row in data do
      id = row['id']
      name = row['name'].force_encoding("UTF-8")
      birthday = row['birthday']
      priority = row['priority']
    end

    #データがない時
    if id.nil? or name.nil? or birthday.nil? or priority.nil? then
      return "データが存在しません"
    end

    month = birthday.slice(0,2)
    day   = birthday.slice(2,2)

    if type == $type_ins then
      output = name + "さんの誕生日を" + month + "月" + day + "日で登録しました\n"
      output = output + "IDは" + id.to_s + "です\n"
      output = output + "優先順位は" + priority.to_s + "です\n"
    elsif type == $type_del then
      output = "ID=" + id.to_s + "\n"
      output = output + name + "さんの誕生日を削除しました\n"
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
      output = output + "・" + name + "さん　(ID=" + id.to_s + ")\n"
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
    oldBirthday = ""
    output = name + "で検索した結果\n"
    for row in data do
      id = row['id']
      viewName = row['name'].force_encoding("UTF-8")
      birthday = row['birthday']
      priority = row['priority']
      if birthday != oldBirthday then
        month = birthday.slice(0,2)
        day   = birthday.slice(2,2)
        output = output + month + "月" + day + "日\n"
        oldBirthday = birthday
      end
      temp = ljust("・" + viewName + "さん", 30)
      output = output + temp + " (ID=" + id.to_s + "　優先順位=" + priority.to_s + ")\n"
      i += 1
    end
    if i == 0 then
      output = output + "対象者はいませんでした。"
    else
      output = output + "以上、" + i.to_s + "名のデータが存在しました。"
    end

    return output
  end


  def ljust(word, width, padding=' ')
    output_width = word.each_char.map{|c| c.bytesize == 1 ? 1 : 2}.reduce(0, &:+)
    padding_size = [0, width - output_width].max
    return word + padding * padding_size
  end
end
