class ArithmeticOperations {
  String _result = '';
  String _resultNumber = '';
  int _firstNumber = 0;
  int _secondNumber = 0;
  String _operation = '';

  String get result => _result;

  String get resultNumber => _resultNumber;

  void clear() {
    _result = '';
    _resultNumber = '';
    _firstNumber = 0;
    _secondNumber = 0;
  }

  void numberPressed(int number) {
    _result += number.toString();
    _resultNumber += number.toString();
  }

  void operationPressed(String operation) {
    _firstNumber = int.parse(_result);
    _operation = operation;
    _result = '';
    _resultNumber = '$_firstNumber $_operation ';
  }

  void equalsPressed() {
    _secondNumber = int.parse(_result);
    double result = 0;
    switch (_operation) {
      case '+':
        result = _firstNumber.toDouble() + _secondNumber.toDouble();
        break;
      case '-':
        result = _firstNumber.toDouble() - _secondNumber.toDouble();
        break;
      case '*':
        result = _firstNumber.toDouble() * _secondNumber.toDouble();
        break;
      case '/':
        result = _firstNumber.toDouble() / _secondNumber.toDouble();
        break;
      default:
        break;
    }
    _resultNumber =
        '$_firstNumber $_operation $_secondNumber = ${result.toString()}';
  }
}
