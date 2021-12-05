const input: ['forward' | 'down' | 'up', number][] = Deno
  .readTextFileSync('./input')
  .split('\n')
  .map(n => n.split(/\s/))
  .map(([a, b]: string[]) => [a as 'forward' | 'down' | 'up', Number(b)]);

const result1: number = input
  .reduce<[number, number]>(
    (prev, curr): [number, number] => {
      switch (curr[0]) {
        case 'up':
          return [prev[0], prev[1] - curr[1]];
        case 'down':
          return [prev[0], prev[1] + curr[1]];
        case 'forward':
          return [prev[0] + curr[1], prev[1]];
        default:
          return prev;
      }
    }, [0, 0])
  .reduce((a, b) => a * b);

console.log(`Answer 1: ${result1}`);

type position = {
  cords: [number, number];
  aim: number;
}

const result2: number = input
  .reduce<position>(
    (prev, curr): position => {
      switch (curr[0]) {
        case 'up':
          return { ...prev, aim: prev['aim'] - curr[1] };
        case 'down':
          return { ...prev, aim: prev['aim'] + curr[1] };
        case 'forward':
          return {
            ...prev,
            cords: [
              prev['cords'][0] + curr[1],
              prev['cords'][1] + (prev['aim'] * curr[1])
            ]
          };
        default:
          return prev;
      }
    }, { cords: [0, 0], aim: 0 })['cords']
  .reduce((a, b) => a * b);

console.log(`Answer 2: ${result2}`);

export { };