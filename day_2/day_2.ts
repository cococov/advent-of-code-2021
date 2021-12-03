const input: [string, number][] = Deno
  .readTextFileSync('./input')
  .split('\n')
  .map(n => n.split(/\s/))
  .map(([a, b]: string[]) => [a, Number(b)]);

console.log(input);

export {};