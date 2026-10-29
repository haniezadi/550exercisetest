DO $$ 
DECLARE
  v_base_id uuid;
BEGIN

  -- Base food: کشک بادمجان با نان (dinner)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('کشک بادمجان با نان', 'compound', 'dinner', NULL, 'dinner:16:کشک-بادمجان-با-نان', 'کشک و روغن محدود داخل وزن غذا حساب شده‌اند. بادمجان سرخ‌شده، گردو و پیازداغ یا نعناع‌داغ اضافه، کالری را بیشتر می‌کنند. از کشک پاستوریزه استفاده کن و دستور آماده‌سازی محصول را رعایت کن.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 110 cal, 5g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'کشک بادمجان با نان — 110 کالری', 'compound', 'dinner', NULL,
    v_base_id, '110 کالری', 110, 5,
    'dinner:16:کشک-بادمجان-با-نان:110', 'null', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 400 cal, 19g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'کشک بادمجان با نان — 400 کالری', 'compound', 'dinner', NULL,
    v_base_id, '400 کالری', 400, 19,
    'dinner:16:کشک-بادمجان-با-نان:400', '[{"name":"کشک بادمجان آماده","amount":"۲۴۰ گرم","household":"۱۶ قاشق غذاخوری سرصاف یا حدود ۱ کاسهٔ کوچک پُر"},{"name":"نان","amount":"۲۰ گرم","household":"⅔ کف دست"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 450 cal, 20g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'کشک بادمجان با نان — 450 کالری', 'compound', 'dinner', NULL,
    v_base_id, '450 کالری', 450, 20,
    'dinner:16:کشک-بادمجان-با-نان:450', '[{"name":"کشک بادمجان آماده","amount":"۲۴۰ گرم","household":"۱۶ قاشق غذاخوری سرصاف یا حدود ۱ کاسهٔ کوچک پُر"},{"name":"نان","amount":"۴۰ گرم","household":"۱⅓ کف دست"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 500 cal, 22g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'کشک بادمجان با نان — 500 کالری', 'compound', 'dinner', NULL,
    v_base_id, '500 کالری', 500, 22,
    'dinner:16:کشک-بادمجان-با-نان:500', '[{"name":"کشک بادمجان آماده","amount":"۲۴۰ گرم","household":"۱۶ قاشق غذاخوری سرصاف یا حدود ۱ کاسهٔ کوچک پُر"},{"name":"نان","amount":"۶۰ گرم","household":"۲ کف دست"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: میرزاقاسمی با نان (dinner)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('میرزاقاسمی با نان', 'compound', 'dinner', NULL, 'dinner:17:میرزاقاسمی-با-نان', 'تخم‌مرغ و روغن داخل وزن غذا هستند؛ جدا اضافه نمی‌شوند. میرزاقاسمی کم‌تخم‌مرغ، پروتئین کمتری دارد و نسخهٔ پرروغن کالری بیشتری خواهد داشت.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 110 cal, 5g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'میرزاقاسمی با نان — 110 کالری', 'compound', 'dinner', NULL,
    v_base_id, '110 کالری', 110, 5,
    'dinner:17:میرزاقاسمی-با-نان:110', 'null', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 400 cal, 19g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'میرزاقاسمی با نان — 400 کالری', 'compound', 'dinner', NULL,
    v_base_id, '400 کالری', 400, 19,
    'dinner:17:میرزاقاسمی-با-نان:400', '[{"name":"میرزاقاسمی آماده","amount":"۲۴۰ گرم","household":"۱۶ قاشق غذاخوری سرصاف یا حدود ۱ کاسهٔ کوچک پُر"},{"name":"نان","amount":"۲۰ گرم","household":"⅔ کف دست"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 450 cal, 20g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'میرزاقاسمی با نان — 450 کالری', 'compound', 'dinner', NULL,
    v_base_id, '450 کالری', 450, 20,
    'dinner:17:میرزاقاسمی-با-نان:450', '[{"name":"میرزاقاسمی آماده","amount":"۲۴۰ گرم","household":"۱۶ قاشق غذاخوری سرصاف یا حدود ۱ کاسهٔ کوچک پُر"},{"name":"نان","amount":"۴۰ گرم","household":"۱⅓ کف دست"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 500 cal, 22g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'میرزاقاسمی با نان — 500 کالری', 'compound', 'dinner', NULL,
    v_base_id, '500 کالری', 500, 22,
    'dinner:17:میرزاقاسمی-با-نان:500', '[{"name":"میرزاقاسمی آماده","amount":"۲۴۰ گرم","household":"۱۶ قاشق غذاخوری سرصاف یا حدود ۱ کاسهٔ کوچک پُر"},{"name":"نان","amount":"۶۰ گرم","household":"۲ کف دست"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: آش رشته (dinner)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('آش رشته', 'compound', 'dinner', NULL, 'dinner:18:آش-رشته', 'رشته، حبوبات، کشک و تزیین کم‌روغن داخل وزن آش حساب شده‌اند؛ نان اضافه ندارد. کشک، پیازداغ و نعناع‌داغ بیشتر از مقدار دستور مبنا، نیازمند محاسبهٔ جداگانه هستند.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 110 cal, 5g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'آش رشته — 110 کالری', 'compound', 'dinner', NULL,
    v_base_id, '110 کالری', 110, 5,
    'dinner:18:آش-رشته:110', 'null', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 400 cal, 20g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'آش رشته — 400 کالری', 'compound', 'dinner', NULL,
    v_base_id, '400 کالری', 400, 20,
    'dinner:18:آش-رشته:400', '[{"name":"آش رشته آماده","amount":"۲۹۰ گرم","household":"حدود ۱¼ کاسهٔ کوچک"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 450 cal, 22g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'آش رشته — 450 کالری', 'compound', 'dinner', NULL,
    v_base_id, '450 کالری', 450, 22,
    'dinner:18:آش-رشته:450', '[{"name":"آش رشته آماده","amount":"۳۳۵ گرم","household":"حدود ۱⅓ کاسهٔ کوچک"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 500 cal, 24g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'آش رشته — 500 کالری', 'compound', 'dinner', NULL,
    v_base_id, '500 کالری', 500, 24,
    'dinner:18:آش-رشته:500', '[{"name":"آش رشته آماده","amount":"۳۸۰ گرم","household":"حدود ۱½ کاسهٔ کوچک"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

END $$;
