part of 'number_trivia_bloc.dart';

abstract class NumberTriviaEvent extends Equatable {
  const NumberTriviaEvent();

  @override
  List<Object> get props => [];
}

class GetTriviaForConcreteNumber extends NumberTriviaEvent {
  final String numberInput;

  const GetTriviaForConcreteNumber(this.numberInput);

  @override
  List<Object> get props => [numberInput];
}

class GetTriviaForRandomNumber extends NumberTriviaEvent {}
