DO $$ 
DECLARE
  v_base_id uuid;
BEGIN

  -- Base food: پروتئین‌بار (breakfast)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('پروتئین‌بار', 'compound', 'breakfast', NULL, 'breakfast:15:پروتئینبار', 'یک پروتئین‌بار فرضی ۵۰ گرمی با ۲۰۰ کالری و ۲۰ گرم پروتئین.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 100 cal, 10g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'پروتئین‌بار — 100 کالری', 'compound', 'breakfast', NULL,
    v_base_id, '100 کالری', 100, 10,
    'breakfast:15:پروتئینبار:100', '[{"name":"پروتئین‌بار","amount":"۲۵ گرم","household":"نصف یک بار ۵۰ گرمی"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 150 cal, 15g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'پروتئین‌بار — 150 کالری', 'compound', 'breakfast', NULL,
    v_base_id, '150 کالری', 150, 15,
    'breakfast:15:پروتئینبار:150', '[{"name":"پروتئین‌بار","amount":"۳۸ گرم","household":"حدود ¾ یک بار ۵۰ گرمی"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 200 cal, 20g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'پروتئین‌بار — 200 کالری', 'compound', 'breakfast', NULL,
    v_base_id, '200 کالری', 200, 20,
    'breakfast:15:پروتئینبار:200', '[{"name":"پروتئین‌بار","amount":"۵۰ گرم","household":"۱ عدد بار ۵۰ گرمی"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 200 cal, 20g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'پروتئین‌بار — 200 کالری', 'compound', 'breakfast', NULL,
    v_base_id, '200 کالری', 200, 20,
    'breakfast:15:پروتئینبار:200', 'null', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: ماست و گردو (snack)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('ماست و گردو', 'compound', 'snack', 'filling', 'snack:1:ماست-و-گردو', 'ماست سادهٔ کم‌چرب و مغز گردوی بدون پوست سخت؛ هر مغز کامل گردوی متوسط حدود ۴ گرم. عسل، کشمش و شکر در محاسبه نیستند. وزن گردو ملاک دقیق‌تر از تعداد است.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 150 cal, 7g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'ماست و گردو — 150 کالری', 'compound', 'snack', 'filling',
    v_base_id, '150 کالری', 150, 7,
    'snack:1:ماست-و-گردو:150', '[{"name":"ماست کم‌چرب","amount":"۱۵۰ گرم","household":"۱۰ قاشق غذاخوری سرصاف"},{"name":"مغز گردو","amount":"۹ گرم","household":"حدود ۲ مغز کامل بزرگ"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 200 cal, 10g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'ماست و گردو — 200 کالری', 'compound', 'snack', 'filling',
    v_base_id, '200 کالری', 200, 10,
    'snack:1:ماست-و-گردو:200', '[{"name":"ماست کم‌چرب","amount":"۲۰۰ گرم","household":"۱۳ قاشق غذاخوری سرصاف"},{"name":"مغز گردو","amount":"۱۲ گرم","household":"۳ مغز کامل متوسط"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 250 cal, 12g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'ماست و گردو — 250 کالری', 'compound', 'snack', 'filling',
    v_base_id, '250 کالری', 250, 12,
    'snack:1:ماست-و-گردو:250', '[{"name":"ماست کم‌چرب","amount":"۲۵۰ گرم","household":"۱ کاسهٔ کوچک پُر"},{"name":"مغز گردو","amount":"۱۵ گرم","household":"حدود ۴ مغز کامل کوچک تا متوسط"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: ماست و نان سنگک (snack)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('ماست و نان سنگک', 'compound', 'snack', 'filling', 'snack:2:ماست-و-نان-سنگک', 'ماست سادهٔ کم‌چرب و نان سنگک؛ هر ۳۰ گرم نان حدود ۱ کف دست بدون انگشتان. ماست چکیده یا پرچرب، با همین وزن کالری و پروتئین متفاوتی دارد.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 150 cal, 7g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'ماست و نان سنگک — 150 کالری', 'compound', 'snack', 'filling',
    v_base_id, '150 کالری', 150, 7,
    'snack:2:ماست-و-نان-سنگک:150', '[{"name":"ماست کم‌چرب","amount":"۱۰۰ گرم","household":"۶–۷ قاشق غذاخوری سرصاف"},{"name":"نان سنگک","amount":"۳۵ گرم","household":"کمی بیشتر از ۱ کف دست"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 200 cal, 10g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'ماست و نان سنگک — 200 کالری', 'compound', 'snack', 'filling',
    v_base_id, '200 کالری', 200, 10,
    'snack:2:ماست-و-نان-سنگک:200', '[{"name":"ماست کم‌چرب","amount":"۱۵۰ گرم","household":"۱۰ قاشق غذاخوری سرصاف"},{"name":"نان سنگک","amount":"۴۲ گرم","household":"حدود ۱½ کف دست"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 250 cal, 13g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'ماست و نان سنگک — 250 کالری', 'compound', 'snack', 'filling',
    v_base_id, '250 کالری', 250, 13,
    'snack:2:ماست-و-نان-سنگک:250', '[{"name":"ماست کم‌چرب","amount":"۲۰۰ گرم","household":"۱۳ قاشق غذاخوری سرصاف"},{"name":"نان سنگک","amount":"۵۰ گرم","household":"۱⅔ کف دست"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

END $$;
