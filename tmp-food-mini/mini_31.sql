DO $$ 
DECLARE
  v_base_id uuid;
BEGIN

  -- Base food: شیر و جو دوسر (snack)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('شیر و جو دوسر', 'compound', 'snack', 'filling', 'snack:9:شیر-و-جو-دوسر', 'شیر کم‌چرب و جو دوسر خشک؛ هر قاشق غذاخوری سرصاف جو دوسر پرک حدود ۵ گرم. وزن جو دوسر پیش از پخت یا خیساندن است. شکر، عسل، مغزها و میوه در این سهم نیستند.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 150 cal, 9g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'شیر و جو دوسر — 150 کالری', 'compound', 'snack', 'filling',
    v_base_id, '150 کالری', 150, 9,
    'snack:9:شیر-و-جو-دوسر:150', '[{"name":"شیر کم‌چرب","amount":"۲۰۰ میلی‌لیتر","household":"حدود ⅞ لیوان استاندارد"},{"name":"جو دوسر خشک","amount":"۱۵ گرم","household":"۳ قاشق غذاخوری سرصاف"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 200 cal, 12g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'شیر و جو دوسر — 200 کالری', 'compound', 'snack', 'filling',
    v_base_id, '200 کالری', 200, 12,
    'snack:9:شیر-و-جو-دوسر:200', '[{"name":"شیر کم‌چرب","amount":"۲۳۰ میلی‌لیتر","household":"۱ لیوان استاندارد"},{"name":"جو دوسر خشک","amount":"۲۴ گرم","household":"حدود ۵ قاشق غذاخوری سرصاف"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 250 cal, 15g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'شیر و جو دوسر — 250 کالری', 'compound', 'snack', 'filling',
    v_base_id, '250 کالری', 250, 15,
    'snack:9:شیر-و-جو-دوسر:250', '[{"name":"شیر کم‌چرب","amount":"۳۰۰ میلی‌لیتر","household":"حدود ۱⅓ لیوان استاندارد"},{"name":"جو دوسر خشک","amount":"۲۹ گرم","household":"حدود ۶ قاشق غذاخوری سرصاف"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: ماست یونانی و یک واحد میوه (snack)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('ماست یونانی و یک واحد میوه', 'compound', 'snack', 'filling', 'snack:10:ماست-یونانی-و-یک-واحد-میوه', 'ماست یونانی سادهٔ کم‌چرب و پرپروتئین با مشخصات گزینهٔ قبل، همراه یک واحد میوهٔ حدود ۶۰ کالری. در هر نسخه فقط یک گزینهٔ میوه انتخاب می‌شود. پروتئین کل با نوع میوه و مشخصات ماست کمی تغییر می‌کند؛ عسل و مغزها در محاسبه نیستند.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 150 cal, 14g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'ماست یونانی و یک واحد میوه — 150 کالری', 'compound', 'snack', 'filling',
    v_base_id, '150 کالری', 150, 14,
    'snack:10:ماست-یونانی-و-یک-واحد-میوه:150', '[{"name":"ماست یونانی پرپروتئین","amount":"۱۳۰ گرم","household":"حدود ۹ قاشق غذاخوری سرصاف"},{"name":"سیب","amount":"۱۱۵ گرم","household":"۱ عدد کوچک"},{"name":"گلابی","amount":"۱۰۵ گرم","household":"۱ عدد کوچک"},{"name":"نارنگی","amount":"۱۱۵ گرم","household":"۲ عدد کوچک"},{"name":"پرتقال","amount":"۱۳۰ گرم","household":"۱ عدد متوسط"},{"name":"انار دانه‌شده","amount":"۷۰ گرم","household":"حدود ½ لیوان"},{"name":"خرمالو","amount":"۸۵ گرم","household":"۱ عدد کوچک"},{"name":"کیوی","amount":"۱۰۰ گرم","household":"۲ عدد کوچک"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 200 cal, 21g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'ماست یونانی و یک واحد میوه — 200 کالری', 'compound', 'snack', 'filling',
    v_base_id, '200 کالری', 200, 21,
    'snack:10:ماست-یونانی-و-یک-واحد-میوه:200', '[{"name":"ماست یونانی پرپروتئین","amount":"۲۰۰ گرم","household":"۱۳ قاشق غذاخوری سرصاف"},{"name":"سیب","amount":"۱۱۵ گرم","household":"۱ عدد کوچک"},{"name":"گلابی","amount":"۱۰۵ گرم","household":"۱ عدد کوچک"},{"name":"نارنگی","amount":"۱۱۵ گرم","household":"۲ عدد کوچک"},{"name":"پرتقال","amount":"۱۳۰ گرم","household":"۱ عدد متوسط"},{"name":"انار دانه‌شده","amount":"۷۰ گرم","household":"حدود ½ لیوان"},{"name":"خرمالو","amount":"۸۵ گرم","household":"۱ عدد کوچک"},{"name":"کیوی","amount":"۱۰۰ گرم","household":"۲ عدد کوچک"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 250 cal, 28g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'ماست یونانی و یک واحد میوه — 250 کالری', 'compound', 'snack', 'filling',
    v_base_id, '250 کالری', 250, 28,
    'snack:10:ماست-یونانی-و-یک-واحد-میوه:250', '[{"name":"ماست یونانی پرپروتئین","amount":"۲۷۰ گرم","household":"۱۸ قاشق غذاخوری سرصاف"},{"name":"سیب","amount":"۱۱۵ گرم","household":"۱ عدد کوچک"},{"name":"گلابی","amount":"۱۰۵ گرم","household":"۱ عدد کوچک"},{"name":"نارنگی","amount":"۱۱۵ گرم","household":"۲ عدد کوچک"},{"name":"پرتقال","amount":"۱۳۰ گرم","household":"۱ عدد متوسط"},{"name":"انار دانه‌شده","amount":"۷۰ گرم","household":"حدود ½ لیوان"},{"name":"خرمالو","amount":"۸۵ گرم","household":"۱ عدد کوچک"},{"name":"کیوی","amount":"۱۰۰ گرم","household":"۲ عدد کوچک"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: شیر و پودر پروتئین (snack)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('شیر و پودر پروتئین', 'compound', 'snack', 'filling', 'snack:11:شیر-و-پودر-پروتئین', 'شیر کم‌چرب و پودر پروتئین با ۱۲۰ کالری / ۲۴ گرم پروتئین در هر ۳۰ گرم؛ پیمانهٔ فرضی ۳۰ گرمی. وزن پیمانه و ترکیب پودرها متفاوت است؛ برچسب محصول ملاک است. مکمل الزامی نیست و این گزینه جایگزینی برای سایر میان‌وعده‌هاست، نه افزودنیِ بدون محاسبه به برنامه.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 150 cal, 19g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'شیر و پودر پروتئین — 150 کالری', 'compound', 'snack', 'filling',
    v_base_id, '150 کالری', 150, 19,
    'snack:11:شیر-و-پودر-پروتئین:150', '[{"name":"شیر کم‌چرب","amount":"۲۰۰ میلی‌لیتر","household":"حدود ⅞ لیوان استاندارد"},{"name":"پودر پروتئین","amount":"۱۵ گرم","household":"نصف پیمانهٔ ۳۰ گرمی"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 200 cal, 27g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'شیر و پودر پروتئین — 200 کالری', 'compound', 'snack', 'filling',
    v_base_id, '200 کالری', 200, 27,
    'snack:11:شیر-و-پودر-پروتئین:200', '[{"name":"شیر کم‌چرب","amount":"۲۳۰ میلی‌لیتر","household":"۱ لیوان استاندارد"},{"name":"پودر پروتئین","amount":"۲۴ گرم","household":"حدود ⅘ پیمانهٔ ۳۰ گرمی"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 250 cal, 33g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'شیر و پودر پروتئین — 250 کالری', 'compound', 'snack', 'filling',
    v_base_id, '250 کالری', 250, 33,
    'snack:11:شیر-و-پودر-پروتئین:250', '[{"name":"شیر کم‌چرب","amount":"۳۰۰ میلی‌لیتر","household":"حدود ۱⅓ لیوان استاندارد"},{"name":"پودر پروتئین","amount":"۲۸ گرم","household":"کمی کمتر از ۱ پیمانهٔ ۳۰ گرمی"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

END $$;
