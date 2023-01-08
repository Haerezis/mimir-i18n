import { v4 as uuidv4 } from 'uuid';

import { ApiTranslationValue, TranslationValue } from "@/types/TranslationValue"

export interface ApiTranslation {
  id: number;
  project_id: number;
  key: string;
  values: { [key: string]: ApiTranslationValue; };
}

export class Translation {
  uuid: string;

  id?: number;
  project_id: number;
  key: string;
  values: { [key: string]: TranslationValue; } = {};

  error_messages: string[] = [];

  constructor() {
    this.uuid = uuidv4();
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

  public init_from_api(data: ApiTranslation) {
    this.id = data.id
    this.project_id = data.project_id
    this.key = data.key
    Object.entries(data.values).forEach(([locale, value_data]) => {
      const value = new TranslationValue().init_from_api(value_data)
      this.values[locale] = value
    })
    
    return this
  }


  public clone() {
    const clone = new Translation()

    clone.id = this.id
    clone.project_id = this.project_id
    clone.key = this.key
    Object.entries(this.values).forEach(([locale, value]) => {
      clone.values[locale] = value.clone()
    })

    return clone
  }

  public get is_new() {
    return !this.id
  }
}

export default Translation
