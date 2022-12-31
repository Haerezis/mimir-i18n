export interface ApiTranslationValue {
  id: number;
  locale: string;
  value: string;
}

export class TranslationValue {
  id?: number;
  locale: string;
  value: string = "";

  public init(locale: string, value?: string) {
    this.locale = locale
    this.value = value

    return this
  }

  public initFromApi(data: ApiTranslationValue) {
    this.id = data.id
    this.locale = data.locale
    this.value = data.value

    return this
  }
}

export default TranslationValue