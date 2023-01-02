export interface ApiTranslationValue {
  id: number;
  locale: string;
  value: string;
}

export class TranslationValue {
  id?: number;
  locale: string;
  value: string = "";
  value_original: string;

  public get value_original() {
    return this._value_original
  }

  public init(locale: string, value?: string) {
    this.locale = locale
    this.value = value
    this.value_original = value

    return this
  }

  public init_from_api(data: ApiTranslationValue) {
    this.id = data.id
    this.locale = data.locale
    this.value = data.value
    this.value_original = data.value

    return this
  }

  public get is_new() {
    return !this.id
  }

  public get is_dirty() {
    return this.value != this.value_original
  }
}

export default TranslationValue
