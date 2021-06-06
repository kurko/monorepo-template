import { default as nodeFetch } from 'node-fetch';

var fetchPolyfill: typeof nodeFetch;

if (typeof(window) === "undefined") {
  fetchPolyfill = nodeFetch;
} else {
  /**
   * For the browser we don't care. For node, however, we want to use the types
   * correctly for TypeScript, so we use nodeFetch for development. The final
   * result should work on both.
   */
  fetchPolyfill = window.fetch as any;
}

export default async function(url: string, options?: object) {
  return fetchPolyfill(url, options);
}
