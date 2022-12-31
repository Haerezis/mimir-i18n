import { ApiTranslationValue, TranslationValue } from "@/types/TranslationValue"

export interface ApiTranslation {
  id: number;
  project_id: number;
  key: string;
  values: { [key: string]: ApiTranslationValue; };
}

export class Translation {
  id?: number;
  project_id: number;
  key: string;
  values: { [key: string]: TranslationValue; };

  public initFromApi(data: ApiTranslation) {
    this.id = data.id
    this.project_id = data.project_id
    this.key = data.key
    Object.entries(data.values).forEach(([locale, value_data]) => {
      const value = new TranslationValue().initFromApi(value_data)
      this.values[locale] = value
    })
    
    return this
  }

  public init(project_id: number, key: string, locales: string[]) {
    this.project_id = project_id
    this.key = key
    locales.forEach((locale) => {
      const value = new TranslationValue().init(locale)
      this.values[locale] = value
    })

    return this
  }
}

export default Translation