import { GithubOutlined } from '@ant-design/icons';
import { DefaultFooter } from '@ant-design/pro-components';
import '@umijs/max';
const Footer: React.FC = () => {
  const defaultMessage = 'BYY出品';
  const currentYear = new Date().getFullYear();
  return (
    <DefaultFooter
      style={{
        background: 'none',
      }}
      copyright={`${currentYear} ${defaultMessage}`}
      links={[
        {
          key: 'BYY',
          title: 'BYY',
          href: 'https://github.com/byyssg',
          blankTarget: true,
        },
        {
          key: 'github',
          title: <GithubOutlined />,
          href: 'https://github.com/byyssg',
          blankTarget: true,
        },
        {
          key: 'API',
          title: 'API',
          href: 'https://github.com/byyssg',
          blankTarget: true,
        },
      ]}
    />
  );
};
export default Footer;
