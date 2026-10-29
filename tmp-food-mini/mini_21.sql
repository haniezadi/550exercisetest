DO $$ 
DECLARE
  v_base_id uuid;
BEGIN

  -- Base food: تخم‌مرغ آب‌پز (snack)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('تخم‌مرغ آب‌پز', 'compound', 'snack', 'simple', 'snack:4:تخممرغ-آبپز', 'هر تخم‌مرغ حدود ۵۰ گرم قسمت خوراکی، ۷۰ کالری و ۶ گرم پروتئین؛ بدون روغن. وزن‌ها بدون پوسته هستند. اندازهٔ تخم‌مرغ می‌تواند کالری و پروتئین را کمی تغییر دهد.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 70 cal, 6g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'تخم‌مرغ آب‌پز — 70 کالری', 'compound', 'snack', 'simple',
    v_base_id, '70 کالری', 70, 6,
    'snack:4:تخممرغ-آبپز:70', '[{"name":"تخم‌مرغ آب‌پز","amount":"۵۰ گرم","household":"۱ عدد"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 140 cal, 13g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'تخم‌مرغ آب‌پز — 140 کالری', 'compound', 'snack', 'simple',
    v_base_id, '140 کالری', 140, 13,
    'snack:4:تخممرغ-آبپز:140', '[{"name":"تخم‌مرغ آب‌پز","amount":"۱۰۰ گرم","household":"۲ عدد"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 220 cal, 19g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'تخم‌مرغ آب‌پز — 220 کالری', 'compound', 'snack', 'simple',
    v_base_id, '220 کالری', 220, 19,
    'snack:4:تخممرغ-آبپز:220', '[{"name":"تخم‌مرغ آب‌پز","amount":"۱۵۰ گرم","household":"۳ عدد"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: خرما (snack)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('خرما', 'compound', 'snack', 'simple', 'snack:5:خرما', 'خرمای کوچک تا متوسط، بدون هسته؛ هر عدد حدود ۸ گرم. برآورد انرژی حدود ۲۸۰ کالری در ۱۰۰ گرم است. خرمای درشت، مانند مجول، با همین تعداد کالری بسیار بیشتری دارد؛ وزن بدون هسته ملاک است.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 90 cal, 1g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'خرما — 90 کالری', 'compound', 'snack', 'simple',
    v_base_id, '90 کالری', 90, 1,
    'snack:5:خرما:90', '[{"name":"خرمای بدون هسته","amount":"۳۲ گرم","household":"۴ عدد کوچک تا متوسط"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 130 cal, 1g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'خرما — 130 کالری', 'compound', 'snack', 'simple',
    v_base_id, '130 کالری', 130, 1,
    'snack:5:خرما:130', '[{"name":"خرمای بدون هسته","amount":"۴۸ گرم","household":"۶ عدد کوچک تا متوسط"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 180 cal, 2g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'خرما — 180 کالری', 'compound', 'snack', 'simple',
    v_base_id, '180 کالری', 180, 2,
    'snack:5:خرما:180', '[{"name":"خرمای بدون هسته","amount":"۶۴ گرم","household":"۸ عدد کوچک تا متوسط"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: مغز گردو (snack)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('مغز گردو', 'compound', 'snack', 'simple', 'snack:6:مغز-گردو', 'هر مغز کامل گردوی متوسط حدود ۴ گرم است؛ یعنی دو نیمهٔ مغز گردو. وزن‌ها مربوط به مغز بدون پوست سخت هستند. اندازهٔ گردوها متفاوت است؛ تعداد فقط معادل تقریبی وزن است.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 100 cal, 2g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'مغز گردو — 100 کالری', 'compound', 'snack', 'simple',
    v_base_id, '100 کالری', 100, 2,
    'snack:6:مغز-گردو:100', '[{"name":"مغز گردو","amount":"۱۶ گرم","household":"۴ مغز کامل گردو یا ۸ نیمه"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 160 cal, 4g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'مغز گردو — 160 کالری', 'compound', 'snack', 'simple',
    v_base_id, '160 کالری', 160, 4,
    'snack:6:مغز-گردو:160', '[{"name":"مغز گردو","amount":"۲۴ گرم","household":"۶ مغز کامل گردو یا ۱۲ نیمه"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 210 cal, 5g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'مغز گردو — 210 کالری', 'compound', 'snack', 'simple',
    v_base_id, '210 کالری', 210, 5,
    'snack:6:مغز-گردو:210', '[{"name":"مغز گردو","amount":"۳۲ گرم","household":"۸ مغز کامل گردو یا ۱۶ نیمه"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

END $$;
