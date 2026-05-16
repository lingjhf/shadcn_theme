import 'package:flutter/material.dart';
import 'package:shadcn_theme/shadcn_theme.dart';

void main() {
  runApp(const ShadcnThemeExampleApp());
}

class ShadcnThemeExampleApp extends StatefulWidget {
  const ShadcnThemeExampleApp({super.key});

  @override
  State<ShadcnThemeExampleApp> createState() => _ShadcnThemeExampleAppState();
}

class _ShadcnThemeExampleAppState extends State<ShadcnThemeExampleApp> {
  ShadcnThemeName theme = ShadcnThemeNames.parse('zinc');
  ShadcnStyleName style = ShadcnStyleNames.parse('nova');
  ThemeMode mode = ThemeMode.system;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'shadcn_theme example',
      debugShowCheckedModeBanner: false,
      themeMode: mode,
      theme: ShadcnThemeData.light(theme: theme, style: style),
      darkTheme: ShadcnThemeData.dark(theme: theme, style: style),
      home: Builder(
        builder: (context) {
          final shadcn = context.shadcnTheme;

          return Scaffold(
            appBar: AppBar(
              title: const Text('shadcn_theme'),
              actions: [
                IconButton(
                  tooltip: 'Toggle brightness',
                  onPressed: () {
                    setState(() {
                      mode = mode == ThemeMode.dark
                          ? ThemeMode.light
                          : ThemeMode.dark;
                    });
                  },
                  icon: Icon(
                    mode == ThemeMode.dark ? Icons.light_mode : Icons.dark_mode,
                  ),
                ),
              ],
            ),
            body: ListView(
              padding: shadcn.style.cardPaddingInsets,
              children: [
                Wrap(
                  spacing: shadcn.style.spacingUnit * 2,
                  runSpacing: shadcn.style.spacingUnit * 2,
                  children: [
                    DropdownMenu<ShadcnThemeName>(
                      label: const Text('Theme'),
                      initialSelection: theme,
                      onSelected: (value) {
                        if (value != null) {
                          setState(() => theme = value);
                        }
                      },
                      dropdownMenuEntries: [
                        for (final value in ShadcnThemeName.values)
                          DropdownMenuEntry(value: value, label: value.label),
                      ],
                    ),
                    DropdownMenu<ShadcnStyleName>(
                      label: const Text('Style'),
                      initialSelection: style,
                      onSelected: (value) {
                        if (value != null) {
                          setState(() => style = value);
                        }
                      },
                      dropdownMenuEntries: [
                        for (final value in ShadcnStyleName.values)
                          DropdownMenuEntry(value: value, label: value.label),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: shadcn.style.cardGap),
                Card(
                  child: Padding(
                    padding: shadcn.style.cardPaddingInsets,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${theme.label} / ${style.label}',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        SizedBox(height: shadcn.style.cardGap / 2),
                        Text(
                          'Surface preview',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        SizedBox(height: shadcn.style.cardGap),
                        Wrap(
                          spacing: shadcn.style.buttonGap,
                          runSpacing: shadcn.style.buttonGap,
                          children: [
                            FilledButton(
                              onPressed: () {},
                              child: const Text('Primary'),
                            ),
                            OutlinedButton(
                              onPressed: () {},
                              child: const Text('Outline'),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: const Text('Text'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: shadcn.style.cardGap),
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Input',
                    hintText: 'Type something',
                  ),
                ),
                SizedBox(height: shadcn.style.cardGap),
                Wrap(
                  spacing: shadcn.style.spacingUnit * 2,
                  runSpacing: shadcn.style.spacingUnit * 2,
                  children: [
                    for (final entry in shadcn.colors.toMap().entries.take(12))
                      _ColorChip(name: entry.key, color: entry.value),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _ColorChip extends StatelessWidget {
  const _ColorChip({required this.name, required this.color});

  final String name;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: CircleAvatar(backgroundColor: color),
      label: Text(name),
    );
  }
}
