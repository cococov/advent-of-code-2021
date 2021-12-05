const input: number[][] = Deno
  .readTextFileSync('./input')
  .split('\n')
  .map(n => n.split('').map(n => Number(n)));

const binaryArrToDecimal = (arr: number[]): number => parseInt(arr.join(''), 2);

const mostCommons = (input: number[][]): number[] => input
  .reduce((acc, row) => acc.map((n, index) => n + row[index]))
  .map(n => n >= (input.length / 2) ? 1 : 0);

const lessCommons = (input: number[][]): number[] => mostCommons(input).map(n => n === 1 ? 0 : 1);


/* --------------------------------------------- */

const result1 = (input: number[][]): number => binaryArrToDecimal(mostCommons(input)) * binaryArrToDecimal(lessCommons(input));

console.log(`Answer 1: ${result1(input)}`);

/* --------------------------------------------- */

const oxygenGeneratorRating = (input: number[][]): number[] => {
  let mutMostCommonsValue = mostCommons(input);
  let mutInput: number[][] = input;
  let mutIndex = 0;

  while (mutInput.length !== 1) {
    mutInput = mutInput.filter(n => n[mutIndex] === mutMostCommonsValue[mutIndex]);
    mutMostCommonsValue = mostCommons(mutInput);
    mutIndex++;
  }

  return mutInput[0];
};

const co2ScrubberRating = (input: number[][]): number[] => {
  let mutLessCommonsValue = lessCommons(input);
  let mutInput: number[][] = input;
  let mutIndex = 0;

  while (mutInput.length !== 1) {
    mutInput = mutInput.filter(n => n[mutIndex] === mutLessCommonsValue[mutIndex]);
    mutLessCommonsValue = lessCommons(mutInput);
    mutIndex++;
  }

  return mutInput[0];
};

const result2 = (input: number[][]): number => binaryArrToDecimal(oxygenGeneratorRating(input)) * binaryArrToDecimal(co2ScrubberRating(input));

console.log(`Answer 2: ${result2(input)}`);

export { };