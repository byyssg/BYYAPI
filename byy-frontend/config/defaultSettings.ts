import { Settings as LayoutSettings } from '@ant-design/pro-components';


const Settings: LayoutSettings & {
  pwa?: boolean;
  logo?: string;
} = {
  navTheme: 'light',
  layout: 'mix',
  contentWidth: 'Fluid',
  fixedHeader: false,
  fixSiderbar: true,
  colorWeak: false,
  title: 'AP1I',
  pwa: false,
  logo: 'b,png',
  iconfontUrl: 'b,png',
};
export default Settings;
