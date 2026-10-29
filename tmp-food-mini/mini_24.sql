DO $$ 
DECLARE
  v_base_id uuid;
BEGIN

  -- Base food: پفک (snack)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('پفک', 'compound', 'snack', 'simple', 'snack:2:پفک', 'اسنک پنیری معمولی با حدود ۵۲۰ کالری / ۶ گرم پروتئین در ۱۰۰ گرم. معادل لیوان با شکل و تراکم پفک تغییر می‌کند؛ یک‌بار سهم محصول خودت را وزن کن.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 100 cal, 1g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'پفک — 100 کالری', 'compound', 'snack', 'simple',
    v_base_id, '100 کالری', 100, 1,
    'snack:2:پفک:100', '[{"name":"پفک","amount":"۱۹ گرم","household":"حدود ۱ لیوان پُر، بدون فشردن"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 150 cal, 2g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'پفک — 150 کالری', 'compound', 'snack', 'simple',
    v_base_id, '150 کالری', 150, 2,
    'snack:2:پفک:150', '[{"name":"پفک","amount":"۲۹ گرم","household":"حدود ۱½ لیوان پُر"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 200 cal, 2g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'پفک — 200 کالری', 'compound', 'snack', 'simple',
    v_base_id, '200 کالری', 200, 2,
    'snack:2:پفک:200', '[{"name":"پفک","amount":"۳۸ گرم","household":"حدود ۲ لیوان پُر"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: بیسکویت ساده (snack)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('بیسکویت ساده', 'compound', 'snack', 'simple', 'snack:3:بیسکویت-ساده', 'بیسکویت ساده با حدود ۴۳۰ کالری / ۷ گرم پروتئین در ۱۰۰ گرم؛ هر عدد فرضی حدود ۶ گرم. اگر بیسکویت‌ها بزرگ‌تر یا کوچک‌ترند، تعداد را با وزن هر عدد روی بسته تنظیم کن.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 100 cal, 2g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'بیسکویت ساده — 100 کالری', 'compound', 'snack', 'simple',
    v_base_id, '100 کالری', 100, 2,
    'snack:3:بیسکویت-ساده:100', '[{"name":"بیسکویت ساده","amount":"۲۳ گرم","household":"حدود ۴ عدد کوچک"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 150 cal, 2g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'بیسکویت ساده — 150 کالری', 'compound', 'snack', 'simple',
    v_base_id, '150 کالری', 150, 2,
    'snack:3:بیسکویت-ساده:150', '[{"name":"بیسکویت ساده","amount":"۳۵ گرم","household":"حدود ۶ عدد کوچک"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 200 cal, 3g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'بیسکویت ساده — 200 کالری', 'compound', 'snack', 'simple',
    v_base_id, '200 کالری', 200, 3,
    'snack:3:بیسکویت-ساده:200', '[{"name":"بیسکویت ساده","amount":"۴۷ گرم","household":"حدود ۸ عدد کوچک"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: بیسکویت کرم‌دار (snack)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('بیسکویت کرم‌دار', 'compound', 'snack', 'simple', 'snack:4:بیسکویت-کرمدار', 'حدود ۴۹۰ کالری / ۵ گرم پروتئین در ۱۰۰ گرم؛ هر عدد فرضی حدود ۱۰ گرم. کرم داخل وزن بیسکویت حساب شده است. تعداد فقط برای بیسکویت حدود ۱۰ گرمی صدق می‌کند.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 100 cal, 1g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'بیسکویت کرم‌دار — 100 کالری', 'compound', 'snack', 'simple',
    v_base_id, '100 کالری', 100, 1,
    'snack:4:بیسکویت-کرمدار:100', '[{"name":"بیسکویت کرم‌دار","amount":"۲۰ گرم","household":"۲ عدد کوچک"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 150 cal, 2g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'بیسکویت کرم‌دار — 150 کالری', 'compound', 'snack', 'simple',
    v_base_id, '150 کالری', 150, 2,
    'snack:4:بیسکویت-کرمدار:150', '[{"name":"بیسکویت کرم‌دار","amount":"۳۰ گرم","household":"۳ عدد کوچک"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 200 cal, 2g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'بیسکویت کرم‌دار — 200 کالری', 'compound', 'snack', 'simple',
    v_base_id, '200 کالری', 200, 2,
    'snack:4:بیسکویت-کرمدار:200', '[{"name":"بیسکویت کرم‌دار","amount":"۴۱ گرم","household":"۴ عدد کوچک"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

END $$;
