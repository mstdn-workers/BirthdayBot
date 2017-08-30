#表示名編集
def editViewName(name, option)
  viewName = name + "さん"
  if option != "" then
    viewName = viewName + " (" + option + ") "
  end
  return viewName
end

#日付編集
def editDate(date)
  if date.include?("/") then
    pDate = date.split("/")
    return format("%02d", pDate[0].to_i) + format("%02d", pDate[1].to_i)
  else
    return date
  end
end

#文字チェック
def checkText(str)
  if str =~ /[\'\"\\\|\n]/ then
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

#文字列の桁合わせ
def ljust(word, width, padding=' ')
  output_width = word.each_char.map{|c| c.bytesize == 1 ? 1 : 2}.reduce(0, &:+)
  padding_size = [0, width - output_width].max
  return word + padding * padding_size
end

