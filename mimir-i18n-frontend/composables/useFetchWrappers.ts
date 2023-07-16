import { UseFetchOptions } from "nuxt/app"

type useFetchType = typeof useFetch

// wrap useFetch with configuration needed to talk to our API
export const useApiFetch: useFetchType = (path, options = {}) => {
  const config = useRuntimeConfig()
  const auth = useAuth()

  options.headers = options.headers ?? {}
  options.headers["authorization"] = auth.token.value

  options.baseURL = config.public.apiBase

  return useFetch(path, options)
}


export function useFetchGET<DataType = any>(
  url: string | Request | Ref<string | Request> | (() => string | Request),
  options?: UseFetchOptions<DataType>
) {
  options = options ?? {}
  options.method = "GET"

  const config = useRuntimeConfig()
  options.baseURL = config.public.apiBase

  return useApiFetch(
    url,
    options
  )
}

export function useFetchPOST<DataType = any>(
  url: string | Request | Ref<string | Request> | (() => string | Request),
  options?: UseFetchOptions<DataType>
) {
  options = options ?? {}
  options.method = "POST"

  const config = useRuntimeConfig()
  options.baseURL = config.public.apiBase

  return useApiFetch(
    url,
    options
  )
}

export function useFetchPATCH<DataType = any>(
  url: string | Request | Ref<string | Request> | (() => string | Request),
  options?: UseFetchOptions<DataType>
) {
  options = options ?? {}
  options.method = "PATCH"

  const config = useRuntimeConfig()
  options.baseURL = config.public.apiBase

  return useApiFetch(
    url,
    options
  )
}


export function useFetchDELETE<DataType = any>(
  url: string | Request | Ref<string | Request> | (() => string | Request),
  options?: UseFetchOptions<DataType>
) {
  options = options ?? {}
  options.method = "DELETE"

  const config = useRuntimeConfig()
  options.baseURL = config.public.apiBase

  return useApiFetch(
    url,
    options
  )
}
