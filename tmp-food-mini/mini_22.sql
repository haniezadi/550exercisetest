DO $$ 
DECLARE
  v_base_id uuid;
BEGIN

  -- Base food: بادام (snack)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('بادام', 'compound', 'snack', 'simple', 'snack:7:بادام', 'بادام خام یا بودادهٔ بدون روغن، بدون روکش؛ هر مغز کامل متوسط حدود ۱٫۲ گرم. بادام روغنی، شکری یا شکلاتی، با این برآورد یکسان نیست.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 100 cal, 4g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'بادام — 100 کالری', 'compound', 'snack', 'simple',
    v_base_id, '100 کالری', 100, 4,
    'snack:7:بادام:100', '[{"name":"بادام","amount":"۱۷ گرم","household":"۱۴ مغز کامل بادام"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 150 cal, 5g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'بادام — 150 کالری', 'compound', 'snack', 'simple',
    v_base_id, '150 کالری', 150, 5,
    'snack:7:بادام:150', '[{"name":"بادام","amount":"۲۶ گرم","household":"۲۲ مغز کامل بادام"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 200 cal, 7g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'بادام — 200 کالری', 'compound', 'snack', 'simple',
    v_base_id, '200 کالری', 200, 7,
    'snack:7:بادام:200', '[{"name":"بادام","amount":"۳۵ گرم","household":"۲۹ مغز کامل بادام"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: خیار (snack)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('خیار', 'compound', 'snack', 'simple', 'snack:8:خیار', 'خیار تازه، بدون سس و روغن؛ حدود ۱۵ کالری در ۱۰۰ گرم. برای خیار، سهم‌های معمول نوشته شده‌اند و مقدار آن برای رسیدن اجباری به ۲۰۰ کالری افزایش داده نشده است.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 20 cal, 1g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'خیار — 20 کالری', 'compound', 'snack', 'simple',
    v_base_id, '20 کالری', 20, 1,
    'snack:8:خیار:20', '[{"name":"خیار","amount":"۱۵۰ گرم","household":"۲ عدد کوچک یا حدود ۱ لیوان خردشده"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 30 cal, 1g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'خیار — 30 کالری', 'compound', 'snack', 'simple',
    v_base_id, '30 کالری', 30, 1,
    'snack:8:خیار:30', '[{"name":"خیار","amount":"۲۰۰ گرم","household":"۲ عدد متوسط یا حدود ۱½ لیوان خردشده"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 40 cal, 2g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'خیار — 40 کالری', 'compound', 'snack', 'simple',
    v_base_id, '40 کالری', 40, 2,
    'snack:8:خیار:40', '[{"name":"خیار","amount":"۲۵۰ گرم","household":"۳ عدد کوچک تا متوسط یا حدود ۲ لیوان خردشده"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 200 cal, nullg protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'خیار — 200 کالری', 'compound', 'snack', 'simple',
    v_base_id, '200 کالری', 200, NULL,
    'snack:8:خیار:200', 'null', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: هویج (snack)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('هویج', 'compound', 'snack', 'simple', 'snack:9:هویج', 'هویج خام، بدون سس و روغن؛ حدود ۴۱ کالری در ۱۰۰ گرم.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 40 cal, 1g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'هویج — 40 کالری', 'compound', 'snack', 'simple',
    v_base_id, '40 کالری', 40, 1,
    'snack:9:هویج:40', '[{"name":"هویج","amount":"۱۰۰ گرم","household":"۱ عدد بزرگ یا ۲ عدد کوچک"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 60 cal, 1g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'هویج — 60 کالری', 'compound', 'snack', 'simple',
    v_base_id, '60 کالری', 60, 1,
    'snack:9:هویج:60', '[{"name":"هویج","amount":"۱۵۰ گرم","household":"۲ عدد متوسط"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 80 cal, 2g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'هویج — 80 کالری', 'compound', 'snack', 'simple',
    v_base_id, '80 کالری', 80, 2,
    'snack:9:هویج:80', '[{"name":"هویج","amount":"۲۰۰ گرم","household":"۲ عدد بزرگ یا ۳ عدد متوسط"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 200 cal, nullg protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'هویج — 200 کالری', 'compound', 'snack', 'simple',
    v_base_id, '200 کالری', 200, NULL,
    'snack:9:هویج:200', 'null', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

END $$;
