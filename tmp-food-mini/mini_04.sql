DO $$ 
DECLARE
  v_base_id uuid;
BEGIN

  -- Base food: کوکوی سبزی، خیار و گوجه (breakfast)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('کوکوی سبزی، خیار و گوجه', 'compound', 'breakfast', NULL, 'breakfast:12:کوکوی-سبزی،-خیار-و-گوجه', 'روش پخت: فرپز یا تابهٔ نچسب با روغن کم. تعداد تکه‌ها تقریبی است؛ ضخامت کوکو بسیار اثر دارد. این اعداد برای کوکوی سرخ‌شده با روغن زیاد معتبر نیستند.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 150 cal, 9g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'کوکوی سبزی، خیار و گوجه — 150 کالری', 'compound', 'breakfast', NULL,
    v_base_id, '150 کالری', 150, 9,
    'breakfast:12:کوکوی-سبزی،-خیار-و-گوجه:150', 'null', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 350 cal, 21g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'کوکوی سبزی، خیار و گوجه — 350 کالری', 'compound', 'breakfast', NULL,
    v_base_id, '350 کالری', 350, 21,
    'breakfast:12:کوکوی-سبزی،-خیار-و-گوجه:350', '[{"name":"کوکوی سبزی آماده","amount":"۲۲۰ گرم","household":"حدود ۴ تکهٔ ۵۵ گرمی"},{"name":"خیار و گوجه","amount":"۱۰۰ گرم","household":"۱ پیمانه کم‌پُر خردشده"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 400 cal, 24g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'کوکوی سبزی، خیار و گوجه — 400 کالری', 'compound', 'breakfast', NULL,
    v_base_id, '400 کالری', 400, 24,
    'breakfast:12:کوکوی-سبزی،-خیار-و-گوجه:400', '[{"name":"کوکوی سبزی آماده","amount":"۲۵۵ گرم","household":"حدود ۵ تکهٔ ۵۰ گرمی"},{"name":"خیار و گوجه","amount":"۱۰۰ گرم","household":"۱ پیمانه کم‌پُر خردشده"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 450 cal, 27g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'کوکوی سبزی، خیار و گوجه — 450 کالری', 'compound', 'breakfast', NULL,
    v_base_id, '450 کالری', 450, 27,
    'breakfast:12:کوکوی-سبزی،-خیار-و-گوجه:450', '[{"name":"کوکوی سبزی آماده","amount":"۲۸۵ گرم","household":"حدود ۵ تکهٔ ۵۵–۶۰ گرمی"},{"name":"خیار و گوجه","amount":"۱۰۰ گرم","household":"۱ پیمانه کم‌پُر خردشده"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: حلیم (breakfast)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('حلیم', 'compound', 'breakfast', NULL, 'breakfast:13:حلیم', 'نکته: حلیم بیرون ممکن است گوشت کمتر یا چربی بیشتری داشته باشد؛ این اعداد برای همهٔ حلیم‌های آماده یکسان نیستند.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 120 cal, 7g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'حلیم — 120 کالری', 'compound', 'breakfast', NULL,
    v_base_id, '120 کالری', 120, 7,
    'breakfast:13:حلیم:120', 'null', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 350 cal, 20g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'حلیم — 350 کالری', 'compound', 'breakfast', NULL,
    v_base_id, '350 کالری', 350, 20,
    'breakfast:13:حلیم:350', '[{"name":"حلیم آماده","amount":"۲۹۰ گرم","household":"کمی بیشتر از ۱ کاسهٔ متوسط ۲۵۰ گرمی"},{"name":"دارچین","amount":"به مقدار دلخواه","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 400 cal, 23g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'حلیم — 400 کالری', 'compound', 'breakfast', NULL,
    v_base_id, '400 کالری', 400, 23,
    'breakfast:13:حلیم:400', '[{"name":"حلیم آماده","amount":"۳۳۵ گرم","household":"حدود ۱⅓ کاسهٔ متوسط"},{"name":"دارچین","amount":"به مقدار دلخواه","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 450 cal, 26g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'حلیم — 450 کالری', 'compound', 'breakfast', NULL,
    v_base_id, '450 کالری', 450, 26,
    'breakfast:13:حلیم:450', '[{"name":"حلیم آماده","amount":"۳۷۵ گرم","household":"حدود ۱٫۵ کاسهٔ متوسط"},{"name":"دارچین","amount":"به مقدار دلخواه","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: شیربرنج با پودر پروتئین (breakfast)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('شیربرنج با پودر پروتئین', 'compound', 'breakfast', NULL, 'breakfast:14:شیربرنج-با-پودر-پروتئین', 'روش تهیه: پودر را ابتدا با کمی آب یا مقداری از خود شیربرنج مخلوط کن و پس از کمی خنک‌شدن، به ظرف اضافه کن تا گلوله نشود. شیرِ اضافه برای حل‌کردن پودر، باید جداگانه محاسبه شود.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 110 cal, 5g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'شیربرنج با پودر پروتئین — 110 کالری', 'compound', 'breakfast', NULL,
    v_base_id, '110 کالری', 110, 5,
    'breakfast:14:شیربرنج-با-پودر-پروتئین:110', 'null', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 80 cal, 16g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'شیربرنج با پودر پروتئین — 80 کالری', 'compound', 'breakfast', NULL,
    v_base_id, '80 کالری', 80, 16,
    'breakfast:14:شیربرنج-با-پودر-پروتئین:80', 'null', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 350 cal, 25g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'شیربرنج با پودر پروتئین — 350 کالری', 'compound', 'breakfast', NULL,
    v_base_id, '350 کالری', 350, 25,
    'breakfast:14:شیربرنج-با-پودر-پروتئین:350', '[{"name":"شیربرنج آماده","amount":"۲۴۵ گرم","household":"۱ کاسهٔ متوسط"},{"name":"پودر پروتئین","amount":"۲۰ گرم","household":"دوسوم پیمانه، فقط اگر پیمانهٔ محصول ۳۰ گرمی باشد"},{"name":"دارچین، هل یا گلاب بدون شکر","amount":"به مقدار دلخواه","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 400 cal, 26g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'شیربرنج با پودر پروتئین — 400 کالری', 'compound', 'breakfast', NULL,
    v_base_id, '400 کالری', 400, 26,
    'breakfast:14:شیربرنج-با-پودر-پروتئین:400', '[{"name":"شیربرنج آماده","amount":"۲۹۰ گرم","household":"کمی بیشتر از ۱ کاسهٔ متوسط"},{"name":"پودر پروتئین","amount":"۲۰ گرم","household":"دوسوم پیمانهٔ ۳۰ گرمی"},{"name":"دارچین، هل یا گلاب بدون شکر","amount":"به مقدار دلخواه","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 450 cal, 28g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'شیربرنج با پودر پروتئین — 450 کالری', 'compound', 'breakfast', NULL,
    v_base_id, '450 کالری', 450, 28,
    'breakfast:14:شیربرنج-با-پودر-پروتئین:450', '[{"name":"شیربرنج آماده","amount":"۳۳۵ گرم","household":"حدود ۱⅓ کاسهٔ متوسط"},{"name":"پودر پروتئین","amount":"۲۰ گرم","household":"دوسوم پیمانهٔ ۳۰ گرمی"},{"name":"دارچین، هل یا گلاب بدون شکر","amount":"به مقدار دلخواه","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

END $$;
