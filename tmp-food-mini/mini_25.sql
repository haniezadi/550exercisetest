DO $$ 
DECLARE
  v_base_id uuid;
BEGIN

  -- Base food: ویفر (snack)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('ویفر', 'compound', 'snack', 'simple', 'snack:5:ویفر', 'ویفر معمولی با حدود ۵۲۰ کالری / ۵ گرم پروتئین در ۱۰۰ گرم؛ هر قطعهٔ فرضی حدود ۱۰ گرم. ویفر با روکش شکلاتی یا اندازهٔ متفاوت باید بر اساس برچسب خودش محاسبه شود.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 100 cal, 1g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'ویفر — 100 کالری', 'compound', 'snack', 'simple',
    v_base_id, '100 کالری', 100, 1,
    'snack:5:ویفر:100', '[{"name":"ویفر","amount":"۱۹ گرم","household":"حدود ۲ قطعهٔ کوچک"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 150 cal, 1g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'ویفر — 150 کالری', 'compound', 'snack', 'simple',
    v_base_id, '150 کالری', 150, 1,
    'snack:5:ویفر:150', '[{"name":"ویفر","amount":"۲۹ گرم","household":"حدود ۳ قطعهٔ کوچک"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 200 cal, 2g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'ویفر — 200 کالری', 'compound', 'snack', 'simple',
    v_base_id, '200 کالری', 200, 2,
    'snack:5:ویفر:200', '[{"name":"ویفر","amount":"۳۸ گرم","household":"حدود ۴ قطعهٔ کوچک"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: کیک بسته‌بندی‌شده (snack)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('کیک بسته‌بندی‌شده', 'compound', 'snack', 'simple', 'snack:6:کیک-بستهبندیشده', 'کیک سادهٔ بسته‌بندی‌شده با حدود ۴۰۰ کالری / ۵ گرم پروتئین در ۱۰۰ گرم؛ بستهٔ فرضی ۵۰ گرمی. کیک مغزدار، شکلاتی یا دارای روکش ممکن است کالری بیشتری داشته باشد.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 100 cal, 1g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'کیک بسته‌بندی‌شده — 100 کالری', 'compound', 'snack', 'simple',
    v_base_id, '100 کالری', 100, 1,
    'snack:6:کیک-بستهبندیشده:100', '[{"name":"کیک","amount":"۲۵ گرم","household":"نصف یک کیک ۵۰ گرمی"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 150 cal, 2g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'کیک بسته‌بندی‌شده — 150 کالری', 'compound', 'snack', 'simple',
    v_base_id, '150 کالری', 150, 2,
    'snack:6:کیک-بستهبندیشده:150', '[{"name":"کیک","amount":"۳۸ گرم","household":"حدود ¾ یک کیک ۵۰ گرمی"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 200 cal, 3g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'کیک بسته‌بندی‌شده — 200 کالری', 'compound', 'snack', 'simple',
    v_base_id, '200 کالری', 200, 3,
    'snack:6:کیک-بستهبندیشده:200', '[{"name":"کیک","amount":"۵۰ گرم","household":"۱ عدد کیک ۵۰ گرمی"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: کلوچه (snack)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('کلوچه', 'compound', 'snack', 'simple', 'snack:7:کلوچه', 'کلوچهٔ معمولی با حدود ۴۳۰ کالری / ۶ گرم پروتئین در ۱۰۰ گرم؛ کلوچهٔ فرضی ۷۰ گرمی. مغز کلوچه داخل وزن سهم حساب شده است؛ اندازهٔ کلوچه و ترکیب مغز آن ثابت نیست.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 100 cal, 1g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'کلوچه — 100 کالری', 'compound', 'snack', 'simple',
    v_base_id, '100 کالری', 100, 1,
    'snack:7:کلوچه:100', '[{"name":"کلوچه","amount":"۲۳ گرم","household":"حدود ⅓ یک کلوچهٔ ۷۰ گرمی"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 150 cal, 2g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'کلوچه — 150 کالری', 'compound', 'snack', 'simple',
    v_base_id, '150 کالری', 150, 2,
    'snack:7:کلوچه:150', '[{"name":"کلوچه","amount":"۳۵ گرم","household":"نصف یک کلوچهٔ ۷۰ گرمی"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 200 cal, 3g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'کلوچه — 200 کالری', 'compound', 'snack', 'simple',
    v_base_id, '200 کالری', 200, 3,
    'snack:7:کلوچه:200', '[{"name":"کلوچه","amount":"۴۷ گرم","household":"حدود ⅔ یک کلوچهٔ ۷۰ گرمی"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

END $$;
