class Interface
  QUESTION_NAME = "Введите ваше имя:"
  QUESTION_ACTION = "Выберите действие:"\
  " 0 - пас, 1 - еще карту, 2 - вскрываемся"

  def input_string
    gets.chomp
  end

  def input_fixnum
    gets.chomp.to_i
  end

  def show_message(message)
    puts message
  end
end
