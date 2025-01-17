import { createEffect, For, Switch, Match } from 'solid-js';
import { createStore } from 'solid-js/store';
import * as i18n from '@solid-primitives/i18n';

import { Character, CharacterView } from '../../../components';

import { useAppState, useAppLocale } from '../../../context';
import { fetchCharactersRequest } from '../../../requests/fetchCharactersRequest';
import { fetchRulesRequest } from '../../../requests/fetchRulesRequest';

export const CharactersPage = (props) => {
  const [pageState, setPageState] = createStore({
    characters: []
  });

  const [appState, { setRules }] = useAppState();
  const [_locale, dict] = useAppLocale();

  const t = i18n.translator(dict);

  createEffect(() => {
    if (appState.rules.length !== 0) return;

    const fetchRules = async () => await fetchRulesRequest(appState.accessToken);
    const fetchCharacters = async () => await fetchCharactersRequest(appState.accessToken);

    Promise.all([fetchRules(), fetchCharacters()]).then(
      ([rulesData, charactersData]) => {
        setRules(rulesData.rules)
        setPageState({
          ...pageState,
          characters: charactersData.characters
        });
      }
    );
  });

  // 453x750
  // 420x690
  return (
    <Switch>
      <Match when={Object.keys(appState.activePageParams).length === 0}>
        <div class="w-full flex justify-between py-4 bg-white border-b border-gray">
          <p class="flex-1 text-center">{t('characters.title')}</p>
        </div>
        <div class="p-4">
          <For each={pageState.characters}>
            {(character) =>
              <Character
                currentRule={appState.rules.find((item) => item.id === character.rule_id).name}
                character={character}
              />
            }
          </For>
        </div>
      </Match>
      <Match when={appState.activePageParams.id}>
        <CharacterView />
      </Match>
    </Switch>
  );
}
