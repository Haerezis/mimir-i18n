export interface ApiTranslationValue {
  id: number;
  locale: string;
  value: string;
}

export class TranslationValue {
  id: number = 0;
  locale: string = "";
  value: string = "";

  public init(locale: string, value: string = "") {
    this.locale = locale
    this.value = value

    return this
  }

  public init_from_api(data: ApiTranslationValue) {
    this.id = data.id
    this.locale = data.locale
    this.value = data.value

    return this
  }

  public clone() {
    const clone = new TranslationValue()

    clone.id = this.id
    clone.locale = this.locale
    clone.value = this.value

    return clone
  }

  public to_json() {
    return {
      id: this.id,
      locale: this.locale,
      value: this.value,
    }
  }
}

export default TranslationValue
