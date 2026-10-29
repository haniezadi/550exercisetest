DO $$ 
DECLARE
  v_base_id uuid;
BEGIN

  -- Base food: پنیر و نان سنگک و خیار (snack)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('پنیر و نان سنگک و خیار', 'compound', 'snack', 'filling', 'snack:6:پنیر-و-نان-سنگک-و-خیار', 'پنیر سفید معمولی با حدود ۲۶۰ کالری / ۱۴ گرم پروتئین در ۱۰۰ گرم؛ بدون کره و گردوی اضافه. پنیر خامه‌ای یا پنیر با درصد چربی متفاوت، باید بر اساس برچسب خودش محاسبه شود.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 150 cal, 7g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'پنیر و نان سنگک و خیار — 150 کالری', 'compound', 'snack', 'filling',
    v_base_id, '150 کالری', 150, 7,
    'snack:6:پنیر-و-نان-سنگک-و-خیار:150', '[{"name":"پنیر سفید","amount":"۳۰ گرم","household":"۱ قوطی کبریت"},{"name":"نان سنگک","amount":"۲۵ گرم","household":"کمی کمتر از ۱ کف دست"},{"name":"خیار","amount":"۵۰ گرم","household":"۱ عدد کوچک"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 200 cal, 9g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'پنیر و نان سنگک و خیار — 200 کالری', 'compound', 'snack', 'filling',
    v_base_id, '200 کالری', 200, 9,
    'snack:6:پنیر-و-نان-سنگک-و-خیار:200', '[{"name":"پنیر سفید","amount":"۳۵ گرم","household":"کمی بیشتر از ۱ قوطی کبریت"},{"name":"نان سنگک","amount":"۳۵ گرم","household":"کمی بیشتر از ۱ کف دست"},{"name":"خیار","amount":"۱۰۰ گرم","household":"۱ عدد متوسط"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 250 cal, 10g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'پنیر و نان سنگک و خیار — 250 کالری', 'compound', 'snack', 'filling',
    v_base_id, '250 کالری', 250, 10,
    'snack:6:پنیر-و-نان-سنگک-و-خیار:250', '[{"name":"پنیر سفید","amount":"۴۰ گرم","household":"۱⅓ قوطی کبریت"},{"name":"نان سنگک","amount":"۵۰ گرم","household":"۱⅔ کف دست"},{"name":"خیار","amount":"۱۰۰ گرم","household":"۱ عدد متوسط"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: تخم‌مرغ و نان سنگک و خیار (snack)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('تخم‌مرغ و نان سنگک و خیار', 'compound', 'snack', 'filling', 'snack:7:تخممرغ-و-نان-سنگک-و-خیار', 'تخم‌مرغ آب‌پز، نان سنگک و خیار؛ بدون روغن. وزن تخم‌مرغ بدون پوسته است؛ سس، کره و روغن اضافه در محاسبه نیستند.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 150 cal, 9g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'تخم‌مرغ و نان سنگک و خیار — 150 کالری', 'compound', 'snack', 'filling',
    v_base_id, '150 کالری', 150, 9,
    'snack:7:تخممرغ-و-نان-سنگک-و-خیار:150', '[{"name":"تخم‌مرغ آب‌پز","amount":"۵۰ گرم","household":"۱ عدد"},{"name":"نان سنگک","amount":"۲۵ گرم","household":"کمی کمتر از ۱ کف دست"},{"name":"خیار","amount":"۱۰۰ گرم","household":"۱ عدد متوسط"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 200 cal, 11g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'تخم‌مرغ و نان سنگک و خیار — 200 کالری', 'compound', 'snack', 'filling',
    v_base_id, '200 کالری', 200, 11,
    'snack:7:تخممرغ-و-نان-سنگک-و-خیار:200', '[{"name":"تخم‌مرغ آب‌پز","amount":"۵۰ گرم","household":"۱ عدد"},{"name":"نان سنگک","amount":"۴۳ گرم","household":"حدود ۱½ کف دست"},{"name":"خیار","amount":"۱۰۰ گرم","household":"۱ عدد متوسط"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 250 cal, 13g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'تخم‌مرغ و نان سنگک و خیار — 250 کالری', 'compound', 'snack', 'filling',
    v_base_id, '250 کالری', 250, 13,
    'snack:7:تخممرغ-و-نان-سنگک-و-خیار:250', '[{"name":"تخم‌مرغ آب‌پز","amount":"۵۰ گرم","household":"۱ عدد"},{"name":"نان سنگک","amount":"۶۳ گرم","household":"کمی بیشتر از ۲ کف دست"},{"name":"خیار","amount":"۱۰۰ گرم","household":"۱ عدد متوسط"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: ماست یونانی پرپروتئین (snack)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('ماست یونانی پرپروتئین', 'compound', 'snack', 'filling', 'snack:8:ماست-یونانی-پرپروتئین', 'ماست یونانی سادهٔ کم‌چرب و پرپروتئین با حدود ۷۰ کالری / ۱۰ گرم پروتئین در ۱۰۰ گرم. همهٔ ماست‌های با عنوان «یونانی» این مقدار پروتئین ندارند. این نسخه‌ها فقط برای محصولی با مشخصات مبنا هستند و عسل یا میوه به آن‌ها اضافه نشده است.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 150 cal, 21g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'ماست یونانی پرپروتئین — 150 کالری', 'compound', 'snack', 'filling',
    v_base_id, '150 کالری', 150, 21,
    'snack:8:ماست-یونانی-پرپروتئین:150', '[{"name":"ماست یونانی پرپروتئین","amount":"۲۱۵ گرم","household":"حدود ۱۴ قاشق غذاخوری سرصاف"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 200 cal, 29g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'ماست یونانی پرپروتئین — 200 کالری', 'compound', 'snack', 'filling',
    v_base_id, '200 کالری', 200, 29,
    'snack:8:ماست-یونانی-پرپروتئین:200', '[{"name":"ماست یونانی پرپروتئین","amount":"۲۸۵ گرم","household":"حدود ۱۹ قاشق غذاخوری سرصاف"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 250 cal, 36g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'ماست یونانی پرپروتئین — 250 کالری', 'compound', 'snack', 'filling',
    v_base_id, '250 کالری', 250, 36,
    'snack:8:ماست-یونانی-پرپروتئین:250', '[{"name":"ماست یونانی پرپروتئین","amount":"۳۵۵ گرم","household":"حدود ۲۴ قاشق غذاخوری سرصاف"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

END $$;
