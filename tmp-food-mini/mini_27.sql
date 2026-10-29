DO $$ 
DECLARE
  v_base_id uuid;
BEGIN

  -- Base food: کراکر (snack)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('کراکر', 'compound', 'snack', 'simple', 'snack:11:کراکر', 'کراکر ساده با حدود ۴۵۰ کالری / ۸ گرم پروتئین در ۱۰۰ گرم؛ هر عدد فرضی حدود ۵ گرم. پنیر، کره یا هر خوراکی همراه کراکر در این سهم نیست.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 100 cal, 2g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'کراکر — 100 کالری', 'compound', 'snack', 'simple',
    v_base_id, '100 کالری', 100, 2,
    'snack:11:کراکر:100', '[{"name":"کراکر","amount":"۲۲ گرم","household":"حدود ۴–۵ عدد کوچک"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 150 cal, 3g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'کراکر — 150 کالری', 'compound', 'snack', 'simple',
    v_base_id, '150 کالری', 150, 3,
    'snack:11:کراکر:150', '[{"name":"کراکر","amount":"۳۳ گرم","household":"حدود ۶–۷ عدد کوچک"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 200 cal, 4g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'کراکر — 200 کالری', 'compound', 'snack', 'simple',
    v_base_id, '200 کالری', 200, 4,
    'snack:11:کراکر:200', '[{"name":"کراکر","amount":"۴۴ گرم","household":"حدود ۹ عدد کوچک"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: شیرینی خشک (snack)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('شیرینی خشک', 'compound', 'snack', 'simple', 'snack:12:شیرینی-خشک', 'شیرینی خشک ساده با حدود ۴۸۰ کالری / ۶ گرم پروتئین در ۱۰۰ گرم؛ هر عدد کوچک فرضی حدود ۱۰ گرم. شیرینی خشک انواع متفاوتی دارد؛ نسخه‌های کره‌ای، مغزدار و شکلاتی الزاماً همین کالری را ندارند.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 100 cal, 1g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'شیرینی خشک — 100 کالری', 'compound', 'snack', 'simple',
    v_base_id, '100 کالری', 100, 1,
    'snack:12:شیرینی-خشک:100', '[{"name":"شیرینی خشک","amount":"۲۱ گرم","household":"حدود ۲ عدد کوچک"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 150 cal, 2g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'شیرینی خشک — 150 کالری', 'compound', 'snack', 'simple',
    v_base_id, '150 کالری', 150, 2,
    'snack:12:شیرینی-خشک:150', '[{"name":"شیرینی خشک","amount":"۳۱ گرم","household":"حدود ۳ عدد کوچک"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 200 cal, 3g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'شیرینی خشک — 200 کالری', 'compound', 'snack', 'simple',
    v_base_id, '200 کالری', 200, 3,
    'snack:12:شیرینی-خشک:200', '[{"name":"شیرینی خشک","amount":"۴۲ گرم","household":"حدود ۴ عدد کوچک"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: دونات کوچک (snack)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('دونات کوچک', 'compound', 'snack', 'simple', 'snack:13:دونات-کوچک', 'دونات ساده بدون کرم و روکش سنگین با حدود ۴۰۰ کالری / ۶ گرم پروتئین در ۱۰۰ گرم؛ دونات کوچک فرضی ۵۰ گرمی. دونات کرم‌دار، شکلاتی یا با لعاب زیاد باید جدا محاسبه شود.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 100 cal, 2g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'دونات کوچک — 100 کالری', 'compound', 'snack', 'simple',
    v_base_id, '100 کالری', 100, 2,
    'snack:13:دونات-کوچک:100', '[{"name":"دونات","amount":"۲۵ گرم","household":"نصف یک دونات کوچک ۵۰ گرمی"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 150 cal, 2g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'دونات کوچک — 150 کالری', 'compound', 'snack', 'simple',
    v_base_id, '150 کالری', 150, 2,
    'snack:13:دونات-کوچک:150', '[{"name":"دونات","amount":"۳۸ گرم","household":"حدود ¾ یک دونات کوچک ۵۰ گرمی"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 200 cal, 3g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'دونات کوچک — 200 کالری', 'compound', 'snack', 'simple',
    v_base_id, '200 کالری', 200, 3,
    'snack:13:دونات-کوچک:200', '[{"name":"دونات","amount":"۵۰ گرم","household":"۱ عدد دونات کوچک ۵۰ گرمی"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

END $$;
