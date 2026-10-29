DO $$ 
DECLARE
  v_base_id uuid;
BEGIN

  
  -- Base food: چیپس (snack)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('چیپس', 'compound', 'snack', 'simple', 'snack:1:چیپس', 'چیپس سیب‌زمینی معمولی با حدود ۵۳۰ کالری / ۶ گرم پروتئین در ۱۰۰ گرم. ضخامت و اندازهٔ برش‌ها متفاوت است؛ وزن و برچسب بسته ملاک هستند.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 100 cal, 1g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'چیپس — 100 کالری', 'compound', 'snack', 'simple',
    v_base_id, '100 کالری', 100, 1,
    'snack:1:چیپس:100', '[{"name":"چیپس","amount":"۱۹ گرم","household":"حدود ۱ مشت کوچک، بدون فشردن"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 150 cal, 2g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'چیپس — 150 کالری', 'compound', 'snack', 'simple',
    v_base_id, '150 کالری', 150, 2,
    'snack:1:چیپس:150', '[{"name":"چیپس","amount":"۲۸ گرم","household":"حدود ۱½ مشت کوچک"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 200 cal, 2g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'چیپس — 200 کالری', 'compound', 'snack', 'simple',
    v_base_id, '200 کالری', 200, 2,
    'snack:1:چیپس:200', '[{"name":"چیپس","amount":"۳۸ گرم","household":"حدود ۲ مشت کوچک"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

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

  -- Base food: شکلات (snack)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('شکلات', 'compound', 'snack', 'simple', 'snack:8:شکلات', 'شکلات شیری ساده با حدود ۵۴۰ کالری / ۷ گرم پروتئین در ۱۰۰ گرم؛ هر مربع فرضی حدود ۵ گرم. شکلات تلخ، مغزدار یا کاراملی برچسب متفاوتی دارد؛ اندازهٔ مربع‌ها نیز یکسان نیست.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 100 cal, 1g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'شکلات — 100 کالری', 'compound', 'snack', 'simple',
    v_base_id, '100 کالری', 100, 1,
    'snack:8:شکلات:100', '[{"name":"شکلات","amount":"۱۹ گرم","household":"حدود ۴ مربع کوچک"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 150 cal, 2g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'شکلات — 150 کالری', 'compound', 'snack', 'simple',
    v_base_id, '150 کالری', 150, 2,
    'snack:8:شکلات:150', '[{"name":"شکلات","amount":"۲۸ گرم","household":"حدود ۶ مربع کوچک"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 200 cal, 3g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'شکلات — 200 کالری', 'compound', 'snack', 'simple',
    v_base_id, '200 کالری', 200, 3,
    'snack:8:شکلات:200', '[{"name":"شکلات","amount":"۳۷ گرم","household":"حدود ۷–۸ مربع کوچک"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: بستنی (snack)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('بستنی', 'compound', 'snack', 'simple', 'snack:9:بستنی', 'بستنی شیری ساده با حدود ۲۰۰ کالری / ۴ گرم پروتئین در ۱۰۰ گرم؛ هر اسکوپ کوچک فرضی حدود ۵۰ گرم. نان بستنی، روکش شکلات، سس و مغزها در محاسبه نیستند. برای بستنی بسته‌بندی‌شده، کالری کل یا سهم مصرفی روی برچسب ملاک است.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 100 cal, 2g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'بستنی — 100 کالری', 'compound', 'snack', 'simple',
    v_base_id, '100 کالری', 100, 2,
    'snack:9:بستنی:100', '[{"name":"بستنی","amount":"۵۰ گرم","household":"۱ اسکوپ کوچک"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 150 cal, 3g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'بستنی — 150 کالری', 'compound', 'snack', 'simple',
    v_base_id, '150 کالری', 150, 3,
    'snack:9:بستنی:150', '[{"name":"بستنی","amount":"۷۵ گرم","household":"۱½ اسکوپ کوچک"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 200 cal, 4g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'بستنی — 200 کالری', 'compound', 'snack', 'simple',
    v_base_id, '200 کالری', 200, 4,
    'snack:9:بستنی:200', '[{"name":"بستنی","amount":"۱۰۰ گرم","household":"۲ اسکوپ کوچک"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: پاپ‌کورن بسته‌بندی‌شده (snack)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('پاپ‌کورن بسته‌بندی‌شده', 'compound', 'snack', 'simple', 'snack:10:پاپکورن-بستهبندیشده', 'پاپ‌کورن نمکیِ روغنی با حدود ۴۸۰ کالری / ۸ گرم پروتئین در ۱۰۰ گرم. این برآورد برای پاپ‌کورن کاراملی یا شکلاتی نیست. مقدار روغن و تراکم محصول، کالری و معادل لیوان را تغییر می‌دهد.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 100 cal, 2g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'پاپ‌کورن بسته‌بندی‌شده — 100 کالری', 'compound', 'snack', 'simple',
    v_base_id, '100 کالری', 100, 2,
    'snack:10:پاپکورن-بستهبندیشده:100', '[{"name":"پاپ‌کورن","amount":"۲۱ گرم","household":"حدود ۲½ لیوان، بدون فشردن"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 150 cal, 2g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'پاپ‌کورن بسته‌بندی‌شده — 150 کالری', 'compound', 'snack', 'simple',
    v_base_id, '150 کالری', 150, 2,
    'snack:10:پاپکورن-بستهبندیشده:150', '[{"name":"پاپ‌کورن","amount":"۳۱ گرم","household":"حدود ۴ لیوان"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 200 cal, 3g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'پاپ‌کورن بسته‌بندی‌شده — 200 کالری', 'compound', 'snack', 'simple',
    v_base_id, '200 کالری', 200, 3,
    'snack:10:پاپکورن-بستهبندیشده:200', '[{"name":"پاپ‌کورن","amount":"۴۲ گرم","household":"حدود ۵ لیوان"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

END $$;
