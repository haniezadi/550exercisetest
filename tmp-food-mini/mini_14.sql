DO $$ 
DECLARE
  v_base_id uuid;
BEGIN

  -- Base food: کباب تابه‌ای با نان (dinner)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('کباب تابه‌ای با نان', 'compound', 'dinner', NULL, 'dinner:6:کباب-تابهای-با-نان', 'گوشت چرخ‌کرده نسبتاً کم‌چرب و پیاز، بدون روغن اضافه؛ هر ۱۰۰ گرم آماده حدود ۲۴۰ کالری / ۲۴ گرم پروتئین. کباب تهیه‌شده با گوشت پرچرب یا روغن اضافه، کالری بیشتری دارد.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 400 cal, 32g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'کباب تابه‌ای با نان — 400 کالری', 'compound', 'dinner', NULL,
    v_base_id, '400 کالری', 400, 32,
    'dinner:6:کباب-تابهای-با-نان:400', '[{"name":"کباب تابه‌ای","amount":"۱۰۰ گرم","household":"۱ کف دست یا ۲ قطعهٔ ۵۰ گرمی"},{"name":"نان","amount":"۳۰ گرم","household":"۱ کف دست"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 450 cal, 33g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'کباب تابه‌ای با نان — 450 کالری', 'compound', 'dinner', NULL,
    v_base_id, '450 کالری', 450, 33,
    'dinner:6:کباب-تابهای-با-نان:450', '[{"name":"کباب تابه‌ای","amount":"۱۰۰ گرم","household":"۱ کف دست یا ۲ قطعهٔ ۵۰ گرمی"},{"name":"نان","amount":"۵۰ گرم","household":"۱⅔ کف دست"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 500 cal, 35g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'کباب تابه‌ای با نان — 500 کالری', 'compound', 'dinner', NULL,
    v_base_id, '500 کالری', 500, 35,
    'dinner:6:کباب-تابهای-با-نان:500', '[{"name":"کباب تابه‌ای","amount":"۱۰۰ گرم","household":"۱ کف دست یا ۲ قطعهٔ ۵۰ گرمی"},{"name":"نان","amount":"۷۰ گرم","household":"۲⅓ کف دست"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: کوکوی سبزی با نان و ماست (dinner)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('کوکوی سبزی با نان و ماست', 'compound', 'dinner', NULL, 'dinner:7:کوکوی-سبزی-با-نان-و-ماست', 'سبزی، تخم‌مرغ و روغن محدود؛ بدون گردو و زرشک افزوده. هر ۱۰۰ گرم آماده حدود ۱۷۰ کالری / ۱۰ گرم پروتئین. ماستِ عنوان غذا همان ۱۰۰ گرم ماست همراه ثابت است، نه علاوه بر آن. تخم‌مرغ و روغن پخت داخل وزن کوکو حساب شده‌اند.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 400 cal, 22g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'کوکوی سبزی با نان و ماست — 400 کالری', 'compound', 'dinner', NULL,
    v_base_id, '400 کالری', 400, 22,
    'dinner:7:کوکوی-سبزی-با-نان-و-ماست:400', '[{"name":"کوکوی سبزی آماده","amount":"۱۵۰ گرم","household":"۲ قطعهٔ متوسطِ ۷۵ گرمی"},{"name":"نان","amount":"۲۵ گرم","household":"کمی کمتر از ۱ کف دست"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 450 cal, 24g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'کوکوی سبزی با نان و ماست — 450 کالری', 'compound', 'dinner', NULL,
    v_base_id, '450 کالری', 450, 24,
    'dinner:7:کوکوی-سبزی-با-نان-و-ماست:450', '[{"name":"کوکوی سبزی آماده","amount":"۱۵۰ گرم","household":"۲ قطعهٔ متوسطِ ۷۵ گرمی"},{"name":"نان","amount":"۴۵ گرم","household":"۱٫۵ کف دست"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 500 cal, 26g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'کوکوی سبزی با نان و ماست — 500 کالری', 'compound', 'dinner', NULL,
    v_base_id, '500 کالری', 500, 26,
    'dinner:7:کوکوی-سبزی-با-نان-و-ماست:500', '[{"name":"کوکوی سبزی آماده","amount":"۱۵۰ گرم","household":"۲ قطعهٔ متوسطِ ۷۵ گرمی"},{"name":"نان","amount":"۶۵ گرم","household":"کمی بیشتر از ۲ کف دست"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: کوکوی سیب‌زمینی با نان و ماست (dinner)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('کوکوی سیب‌زمینی با نان و ماست', 'compound', 'dinner', NULL, 'dinner:8:کوکوی-سیبزمینی-با-نان-و-ماست', 'سیب‌زمینی، تخم‌مرغ و روغن محدود؛ هر ۱۰۰ گرم آماده حدود ۱۷۰ کالری / ۶ گرم پروتئین. سیب‌زمینی، تخم‌مرغ و روغن داخل وزن کوکو هستند. ماست دوباره اضافه نمی‌شود؛ کوکوی پرروغن کالری بیشتری دارد.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 400 cal, 16g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'کوکوی سیب‌زمینی با نان و ماست — 400 کالری', 'compound', 'dinner', NULL,
    v_base_id, '400 کالری', 400, 16,
    'dinner:8:کوکوی-سیبزمینی-با-نان-و-ماست:400', '[{"name":"کوکوی سیب‌زمینی آماده","amount":"۱۵۰ گرم","household":"۲ عدد یا ۲ قطعهٔ متوسطِ ۷۵ گرمی"},{"name":"نان","amount":"۲۵ گرم","household":"کمی کمتر از ۱ کف دست"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 450 cal, 18g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'کوکوی سیب‌زمینی با نان و ماست — 450 کالری', 'compound', 'dinner', NULL,
    v_base_id, '450 کالری', 450, 18,
    'dinner:8:کوکوی-سیبزمینی-با-نان-و-ماست:450', '[{"name":"کوکوی سیب‌زمینی آماده","amount":"۱۵۰ گرم","household":"۲ عدد یا ۲ قطعهٔ متوسطِ ۷۵ گرمی"},{"name":"نان","amount":"۴۵ گرم","household":"۱٫۵ کف دست"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 500 cal, 20g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'کوکوی سیب‌زمینی با نان و ماست — 500 کالری', 'compound', 'dinner', NULL,
    v_base_id, '500 کالری', 500, 20,
    'dinner:8:کوکوی-سیبزمینی-با-نان-و-ماست:500', '[{"name":"کوکوی سیب‌زمینی آماده","amount":"۱۵۰ گرم","household":"۲ عدد یا ۲ قطعهٔ متوسطِ ۷۵ گرمی"},{"name":"نان","amount":"۶۵ گرم","household":"کمی بیشتر از ۲ کف دست"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

END $$;
