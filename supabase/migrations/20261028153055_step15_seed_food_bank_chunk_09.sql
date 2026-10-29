DO $$ 
DECLARE
  v_base_id uuid;
BEGIN
  
  -- Base food: تخم‌مرغ و نان سنگک و خیار (snack)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('تخم‌مرغ و نان سنگک و خیار', 'compound', 'snack', 'filling', 'snack:7:تخممرغ-و-نان-سنگک-و-خیار', 'تخم‌مرغ آب‌پز، نان سنگک و خیار؛ بدون روغن. وزن تخم‌مرغ بدون پوسته است؛ سس، کره و روغن اضافه در محاسبه نیستند.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES ('تخم‌مرغ و نان سنگک و خیار — 150 کالری', 'compound', 'snack', 'filling', v_base_id, '150 کالری', 150, 9, 'snack:7:تخممرغ-و-نان-سنگک-و-خیار:150', '[{"name":"تخم‌مرغ آب‌پز","amount":"۵۰ گرم","household":"۱ عدد"},{"name":"نان سنگک","amount":"۲۵ گرم","household":"کمی کمتر از ۱ کف دست"},{"name":"خیار","amount":"۱۰۰ گرم","household":"۱ عدد متوسط"}]', NULL)
  ON CONFLICT (source_key) DO UPDATE SET parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein, ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES ('تخم‌مرغ و نان سنگک و خیار — 200 کالری', 'compound', 'snack', 'filling', v_base_id, '200 کالری', 200, 11, 'snack:7:تخممرغ-و-نان-سنگک-و-خیار:200', '[{"name":"تخم‌مرغ آب‌پز","amount":"۵۰ گرم","household":"۱ عدد"},{"name":"نان سنگک","amount":"۴۳ گرم","household":"حدود ۱½ کف دست"},{"name":"خیار","amount":"۱۰۰ گرم","household":"۱ عدد متوسط"}]', NULL)
  ON CONFLICT (source_key) DO UPDATE SET parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein, ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES ('تخم‌مرغ و نان سنگک و خیار — 250 کالری', 'compound', 'snack', 'filling', v_base_id, '250 کالری', 250, 13, 'snack:7:تخممرغ-و-نان-سنگک-و-خیار:250', '[{"name":"تخم‌مرغ آب‌پز","amount":"۵۰ گرم","household":"۱ عدد"},{"name":"نان سنگک","amount":"۶۳ گرم","household":"کمی بیشتر از ۲ کف دست"},{"name":"خیار","amount":"۱۰۰ گرم","household":"۱ عدد متوسط"}]', NULL)
  ON CONFLICT (source_key) DO UPDATE SET parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein, ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: ماست یونانی پرپروتئین (snack)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('ماست یونانی پرپروتئین', 'compound', 'snack', 'filling', 'snack:8:ماست-یونانی-پرپروتئین', 'ماست یونانی سادهٔ کم‌چرب و پرپروتئین با حدود ۷۰ کالری / ۱۰ گرم پروتئین در ۱۰۰ گرم.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES ('ماست یونانی پرپروتئین — 150 کالری', 'compound', 'snack', 'filling', v_base_id, '150 کالری', 150, 21, 'snack:8:ماست-یونانی-پرپروتئین:150', '[{"name":"ماست یونانی پرپروتئین","amount":"۲۱۵ گرم","household":"حدود ۱۴ قاشق غذاخوری سرصاف"}]', NULL)
  ON CONFLICT (source_key) DO UPDATE SET parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein, ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES ('ماست یونانی پرپروتئین — 200 کالری', 'compound', 'snack', 'filling', v_base_id, '200 کالری', 200, 29, 'snack:8:ماست-یونانی-پرپروتئین:200', '[{"name":"ماست یونانی پرپروتئین","amount":"۲۸۵ گرم","household":"حدود ۱۹ قاشق غذاخوری سرصاف"}]', NULL)
  ON CONFLICT (source_key) DO UPDATE SET parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein, ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES ('ماست یونانی پرپروتئین — 250 کالری', 'compound', 'snack', 'filling', v_base_id, '250 کالری', 250, 36, 'snack:8:ماست-یونانی-پرپروتئین:250', '[{"name":"ماست یونانی پرپروتئین","amount":"۳۵۵ گرم","household":"حدود ۲۴ قاشق غذاخوری سرصاف"}]', NULL)
  ON CONFLICT (source_key) DO UPDATE SET parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein, ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: شیر و جو دوسر (snack)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('شیر و جو دوسر', 'compound', 'snack', 'filling', 'snack:9:شیر-و-جو-دوسر', 'شیر کم‌چرب و جو دوسر خشک. شکر، عسل، مغزها و میوه در این سهم نیستند.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES ('شیر و جو دوسر — 150 کالری', 'compound', 'snack', 'filling', v_base_id, '150 کالری', 150, 9, 'snack:9:شیر-و-جو-دوسر:150', '[{"name":"شیر کم‌چرب","amount":"۲۰۰ میلی‌لیتر","household":"حدود ⅞ لیوان استاندارد"},{"name":"جو دوسر خشک","amount":"۱۵ گرم","household":"۳ قاشق غذاخوری سرصاف"}]', NULL)
  ON CONFLICT (source_key) DO UPDATE SET parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein, ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES ('شیر و جو دوسر — 200 کالری', 'compound', 'snack', 'filling', v_base_id, '200 کالری', 200, 12, 'snack:9:شیر-و-جو-دوسر:200', '[{"name":"شیر کم‌چرب","amount":"۲۳۰ میلی‌لیتر","household":"۱ لیوان استاندارد"},{"name":"جو دوسر خشک","amount":"۲۴ گرم","household":"حدود ۵ قاشق غذاخوری سرصاف"}]', NULL)
  ON CONFLICT (source_key) DO UPDATE SET parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein, ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES ('شیر و جو دوسر — 250 کالری', 'compound', 'snack', 'filling', v_base_id, '250 کالری', 250, 15, 'snack:9:شیر-و-جو-دوسر:250', '[{"name":"شیر کم‌چرب","amount":"۳۰۰ میلی‌لیتر","household":"حدود ۱⅓ لیوان استاندارد"},{"name":"جو دوسر خشک","amount":"۲۹ گرم","household":"حدود ۶ قاشق غذاخوری سرصاف"}]', NULL)
  ON CONFLICT (source_key) DO UPDATE SET parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein, ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: ماست یونانی و یک واحد میوه (snack)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('ماست یونانی و یک واحد میوه', 'compound', 'snack', 'filling', 'snack:10:ماست-یونانی-و-یک-واحد-میوه', 'ماست یونانی سادهٔ کم‌چرب و پرپروتئین همراه یک واحد میوهٔ حدود ۶۰ کالری. عسل و مغزها در محاسبه نیستند.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES ('ماست یونانی و یک واحد میوه — 150 کالری', 'compound', 'snack', 'filling', v_base_id, '150 کالری', 150, 14, 'snack:10:ماست-یونانی-و-یک-واحد-میوه:150', '[{"name":"ماست یونانی پرپروتئین","amount":"۱۳۰ گرم","household":"حدود ۹ قاشق غذاخوری سرصاف"},{"name":"سیب","amount":"۱۱۵ گرم","household":"۱ عدد کوچک"},{"name":"گلابی","amount":"۱۰۵ گرم","household":"۱ عدد کوچک"},{"name":"نارنگی","amount":"۱۱۵ گرم","household":"۲ عدد کوچک"},{"name":"پرتقال","amount":"۱۳۰ گرم","household":"۱ عدد متوسط"},{"name":"انار دانه‌شده","amount":"۷۰ گرم","household":"حدود ½ لیوان"},{"name":"خرمالو","amount":"۸۵ گرم","household":"۱ عدد کوچک"},{"name":"کیوی","amount":"۱۰۰ گرم","household":"۲ عدد کوچک"}]', NULL)
  ON CONFLICT (source_key) DO UPDATE SET parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein, ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES ('ماست یونانی و یک واحد میوه — 200 کالری', 'compound', 'snack', 'filling', v_base_id, '200 کالری', 200, 21, 'snack:10:ماست-یونانی-و-یک-واحد-میوه:200', '[{"name":"ماست یونانی پرپروتئین","amount":"۲۰۰ گرم","household":"۱۳ قاشق غذاخوری سرصاف"},{"name":"سیب","amount":"۱۱۵ گرم","household":"۱ عدد کوچک"},{"name":"گلابی","amount":"۱۰۵ گرم","household":"۱ عدد کوچک"},{"name":"نارنگی","amount":"۱۱۵ گرم","household":"۲ عدد کوچک"},{"name":"پرتقال","amount":"۱۳۰ گرم","household":"۱ عدد متوسط"},{"name":"انار دانه‌شده","amount":"۷۰ گرم","household":"حدود ½ لیوان"},{"name":"خرمالو","amount":"۸۵ گرم","household":"۱ عدد کوچک"},{"name":"کیوی","amount":"۱۰۰ گرم","household":"۲ عدد کوچک"}]', NULL)
  ON CONFLICT (source_key) DO UPDATE SET parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein, ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES ('ماست یونانی و یک واحد میوه — 250 کالری', 'compound', 'snack', 'filling', v_base_id, '250 کالری', 250, 28, 'snack:10:ماست-یونانی-و-یک-واحد-میوه:250', '[{"name":"ماست یونانی پرپروتئین","amount":"۲۷۰ گرم","household":"۱۸ قاشق غذاخوری سرصاف"},{"name":"سیب","amount":"۱۱۵ گرم","household":"۱ عدد کوچک"},{"name":"گلابی","amount":"۱۰۵ گرم","household":"۱ عدد کوچک"},{"name":"نارنگی","amount":"۱۱۵ گرم","household":"۲ عدد کوچک"},{"name":"پرتقال","amount":"۱۳۰ گرم","household":"۱ عدد متوسط"},{"name":"انار دانه‌شده","amount":"۷۰ گرم","household":"حدود ½ لیوان"},{"name":"خرمالو","amount":"۸۵ گرم","household":"۱ عدد کوچک"},{"name":"کیوی","amount":"۱۰۰ گرم","household":"۲ عدد کوچک"}]', NULL)
  ON CONFLICT (source_key) DO UPDATE SET parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein, ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: شیر و پودر پروتئین (snack)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('شیر و پودر پروتئین', 'compound', 'snack', 'filling', 'snack:11:شیر-و-پودر-پروتئین', 'شیر کم‌چرب و پودر پروتئین با ۱۲۰ کالری / ۲۴ گرم پروتئین در هر ۳۰ گرم.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES ('شیر و پودر پروتئین — 150 کالری', 'compound', 'snack', 'filling', v_base_id, '150 کالری', 150, 19, 'snack:11:شیر-و-پودر-پروتئین:150', '[{"name":"شیر کم‌چرب","amount":"۲۰۰ میلی‌لیتر","household":"حدود ⅞ لیوان استاندارد"},{"name":"پودر پروتئین","amount":"۱۵ گرم","household":"نصف پیمانهٔ ۳۰ گرمی"}]', NULL)
  ON CONFLICT (source_key) DO UPDATE SET parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein, ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES ('شیر و پودر پروتئین — 200 کالری', 'compound', 'snack', 'filling', v_base_id, '200 کالری', 200, 27, 'snack:11:شیر-و-پودر-پروتئین:200', '[{"name":"شیر کم‌چرب","amount":"۲۳۰ میلی‌لیتر","household":"۱ لیوان استاندارد"},{"name":"پودر پروتئین","amount":"۲۴ گرم","household":"حدود ⅘ پیمانهٔ ۳۰ گرمی"}]', NULL)
  ON CONFLICT (source_key) DO UPDATE SET parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein, ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES ('شیر و پودر پروتئین — 250 کالری', 'compound', 'snack', 'filling', v_base_id, '250 کالری', 250, 33, 'snack:11:شیر-و-پودر-پروتئین:250', '[{"name":"شیر کم‌چرب","amount":"۳۰۰ میلی‌لیتر","household":"حدود ۱⅓ لیوان استاندارد"},{"name":"پودر پروتئین","amount":"۲۸ گرم","household":"کمی کمتر از ۱ پیمانهٔ ۳۰ گرمی"}]', NULL)
  ON CONFLICT (source_key) DO UPDATE SET parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein, ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: دو عدد تخم‌مرغ و نان سنگک (snack)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('دو عدد تخم‌مرغ و نان سنگک', 'compound', 'snack', 'filling', 'snack:12:دو-عدد-تخممرغ-و-نان-سنگک', 'دو تخم‌مرغ آب‌پز بدون روغن. وزن بدون پوسته و بدون روغن محاسبه شده است.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES ('دو عدد تخم‌مرغ و نان سنگک — 180 کالری', 'compound', 'snack', 'filling', v_base_id, '180 کالری', 180, 14, 'snack:12:دو-عدد-تخممرغ-و-نان-سنگک:180', '[{"name":"تخم‌مرغ آب‌پز","amount":"۱۰۰ گرم","household":"۲ عدد"},{"name":"نان سنگک","amount":"۱۵ گرم","household":"½ کف دست"}]', NULL)
  ON CONFLICT (source_key) DO UPDATE SET parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein, ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES ('دو عدد تخم‌مرغ و نان سنگک — 200 کالری', 'compound', 'snack', 'filling', v_base_id, '200 کالری', 200, 14, 'snack:12:دو-عدد-تخممرغ-و-نان-سنگک:200', '[{"name":"تخم‌مرغ آب‌پز","amount":"۱۰۰ گرم","household":"۲ عدد"},{"name":"نان سنگک","amount":"۲۲ گرم","household":"حدود ¾ کف دست"}]', NULL)
  ON CONFLICT (source_key) DO UPDATE SET parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein, ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES ('دو عدد تخم‌مرغ و نان سنگک — 250 کالری', 'compound', 'snack', 'filling', v_base_id, '250 کالری', 250, 16, 'snack:12:دو-عدد-تخممرغ-و-نان-سنگک:250', '[{"name":"تخم‌مرغ آب‌پز","amount":"۱۰۰ گرم","household":"۲ عدد"},{"name":"نان سنگک","amount":"۴۱ گرم","household":"حدود ۱⅓ کف دست"}]', NULL)
  ON CONFLICT (source_key) DO UPDATE SET parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein, ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: پنیر و گردو و نان سنگک (snack)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('پنیر و گردو و نان سنگک', 'compound', 'snack', 'filling', 'snack:13:پنیر-و-گردو-و-نان-سنگک', 'پنیر سفید معمولی، مغز گردو و نان سنگک؛ بدون کره.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES ('پنیر و گردو و نان سنگک — 150 کالری', 'compound', 'snack', 'filling', v_base_id, '150 کالری', 150, 5, 'snack:13:پنیر-و-گردو-و-نان-سنگک:150', '[{"name":"پنیر سفید","amount":"۲۰ گرم","household":"حدود ⅔ قوطی کبریت"},{"name":"مغز گردو","amount":"۴ گرم","household":"۱ مغز کامل متوسط"},{"name":"نان سنگک","amount":"۲۸ گرم","household":"حدود ۱ کف دست"}]', NULL)
  ON CONFLICT (source_key) DO UPDATE SET parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein, ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES ('پنیر و گردو و نان سنگک — 200 کالری', 'compound', 'snack', 'filling', v_base_id, '200 کالری', 200, 6, 'snack:13:پنیر-و-گردو-و-نان-سنگک:200', '[{"name":"پنیر سفید","amount":"۲۵ گرم","household":"کمی کمتر از ۱ قوطی کبریت"},{"name":"مغز گردو","amount":"۸ گرم","household":"۲ مغز کامل متوسط"},{"name":"نان سنگک","amount":"۳۲ گرم","household":"کمی بیشتر از ۱ کف دست"}]', NULL)
  ON CONFLICT (source_key) DO UPDATE SET parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein, ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES ('پنیر و گردو و نان سنگک — 250 کالری', 'compound', 'snack', 'filling', v_base_id, '250 کالری', 250, 8, 'snack:13:پنیر-و-گردو-و-نان-سنگک:250', '[{"name":"پنیر سفید","amount":"۳۰ گرم","household":"۱ قوطی کبریت"},{"name":"مغز گردو","amount":"۸ گرم","household":"۲ مغز کامل متوسط"},{"name":"نان سنگک","amount":"۴۶ گرم","household":"حدود ۱½ کف دست"}]', NULL)
  ON CONFLICT (source_key) DO UPDATE SET parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein, ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: سیب‌زمینی آب‌پز و تخم‌مرغ (snack)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('سیب‌زمینی آب‌پز و تخم‌مرغ', 'compound', 'snack', 'filling', 'snack:14:سیبزمینی-آبپز-و-تخممرغ', 'سیب‌زمینی آب‌پز و تخم‌مرغ آب‌پز، بدون روغن، کره و مایونز.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES ('سیب‌زمینی آب‌پز و تخم‌مرغ — 150 کالری', 'compound', 'snack', 'filling', v_base_id, '150 کالری', 150, 8, 'snack:14:سیبزمینی-آبپز-و-تخممرغ:150', '[{"name":"سیب‌زمینی آب‌پز","amount":"۹۰ گرم","household":"۱ عدد کوچک"},{"name":"تخم‌مرغ آب‌پز","amount":"۵۰ گرم","household":"۱ عدد"}]', NULL)
  ON CONFLICT (source_key) DO UPDATE SET parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein, ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES ('سیب‌زمینی آب‌پز و تخم‌مرغ — 200 کالری', 'compound', 'snack', 'filling', v_base_id, '200 کالری', 200, 9, 'snack:14:سیبزمینی-آبپز-و-تخممرغ:200', '[{"name":"سیب‌زمینی آب‌پز","amount":"۱۴۵ گرم","household":"۱ عدد متوسط"},{"name":"تخم‌مرغ آب‌پز","amount":"۵۰ گرم","household":"۱ عدد"}]', NULL)
  ON CONFLICT (source_key) DO UPDATE SET parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein, ingredients = EXcluded.ingredients, version_label = EXCLUDED.version_label;

  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES ('سیب‌زمینی آب‌پز و تخم‌مرغ — 250 کالری', 'compound', 'snack', 'filling', v_base_id, '250 کالری', 250, 10, 'snack:14:سیبزمینی-آبپز-و-تخممرغ:250', '[{"name":"سیب‌زمینی آب‌پز","amount":"۲۰۵ گرم","household":"۱ عدد بزرگ یا ۲ عدد کوچک"},{"name":"تخم‌مرغ آب‌پز","amount":"۵۰ گرم","household":"۱ عدد"}]', NULL)
  ON CONFLICT (source_key) DO UPDATE SET parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein, ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: سیب‌زمینی آب‌پز یا کبابی (snack)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('سیب‌زمینی آب‌پز یا کبابی', 'compound', 'snack', 'filling', 'snack:15:سیبزمینی-آبپز-یا-کبابی', 'سیب‌زمینی بدون روغن و کره. فقط یکی از دو روش انتخاب می‌شود.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES ('سیب‌زمینی آب‌پز یا کبابی — 150 کالری', 'compound', 'snack', 'filling', v_base_id, '150 کالری', 150, 4, 'snack:15:سیبزمینی-آبپز-یا-کبابی:150', '[{"name":"سیب‌زمینی آب‌پز","amount":"۱۷۰ گرم","household":"۱ عدد متوسط رو به بزرگ"},{"name":"سیب‌زمینی کبابی","amount":"۱۶۰ گرم","household":"۱ عدد متوسط"}]', NULL)
  ON CONFLICT (source_key) DO UPDATE SET parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein, ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES ('سیب‌زمینی آب‌پز یا کبابی — 200 کالری', 'compound', 'snack', 'filling', v_base_id, '200 کالری', 200, 5, 'snack:15:سیبزمینی-آبپز-یا-کبابی:200', '[{"name":"سیب‌زمینی آب‌پز","amount":"۲۳۰ گرم","household":"۱ عدد بزرگ"},{"name":"سیب‌زمینی کبابی","amount":"۲۱۵ گرم","household":"۱ عدد بزرگ یا ۲ عدد کوچک"}]', NULL)
  ON CONFLICT (source_key) DO UPDATE SET parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein, ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES ('سیب‌زمینی آب‌پز یا کبابی — 250 کالری', 'compound', 'snack', 'filling', v_base_id, '250 کالری', 250, 7, 'snack:15:سیبزمینی-آبپز-یا-کبابی:250', '[{"name":"سیب‌زمینی آب‌پز","amount":"۲۸۵ گرم","household":"۲ عدد متوسط"},{"name":"سیب‌زمینی کبابی","amount":"۲۷۰ گرم","household":"۲ عدد متوسط"}]', NULL)
  ON CONFLICT (source_key) DO UPDATE SET parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein, ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: ماست و موز و جو دوسر (snack)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('ماست و موز و جو دوسر', 'compound', 'snack', 'filling', 'snack:16:ماست-و-موز-و-جو-دوسر', 'ماست سادهٔ کم‌چرب، موز بدون پوست و جو دوسر خشک؛ بدون عسل، شکر و مغزها.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES ('ماست و موز و جو دوسر — 150 کالری', 'compound', 'snack', 'filling', v_base_id, '150 کالری', 150, 6, 'snack:16:ماست-و-موز-و-جو-دوسر:150', '[{"name":"ماست کم‌چرب","amount":"۱۰۰ گرم","household":"۶–۷ قاشق غذاخوری سرصاف"},{"name":"موز","amount":"۵۵ گرم","household":"حدود نصف یک موز کوچک"},{"name":"جو دوسر خشک","amount":"۱۰ گرم","household":"۲ قاشق غذاخوری سرصاف"}]', NULL)
  ON CONFLICT (source_key) DO UPDATE SET parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein, ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES ('ماست و موز و جو دوسر — 200 کالری', 'compound', 'snack', 'filling', v_base_id, '200 کالری', 200, 10, 'snack:16:ماست-و-موز-و-جو-دوسر:200', '[{"name":"ماست کم‌چرب","amount":"۱۵۰ گرم","household":"۱۰ قاشق غذاخوری سرصاف"},{"name":"موز","amount":"۶۰ گرم","household":"نصف یک موز متوسط"},{"name":"جو دوسر خشک","amount":"۱۵ گرم","household":"۳ قاشق غذاخوری سرصاف"}]', NULL)
  ON CONFLICT (source_key) DO UPDATE SET parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein, ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES ('ماست و موز و جو دوسر — 250 کالری', 'compound', 'snack', 'filling', v_base_id, '250 کالری', 250, 12, 'snack:16:ماست-و-موز-و-جو-دوسر:250', '[{"name":"ماست کم‌چرب","amount":"۲۰۰ گرم","household":"۱۳ قاشق غذاخوری سرصاف"},{"name":"موز","amount":"۸۰ گرم","household":"حدود ⅔ یک موز متوسط"},{"name":"جو دوسر خشک","amount":"۱۵ گرم","household":"۳ قاشق غذاخوری سرصاف"}]', NULL)
  ON CONFLICT (source_key) DO UPDATE SET parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein, ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

END $$;