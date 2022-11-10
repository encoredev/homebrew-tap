class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.10.3"
    checksums = {
        "darwin_arm64" => "61dd25798e8b41877aed287d2f93e10eb66111382ff6daf24b72614f9eabb572",
        "darwin_amd64" => "77d1bf7984cef1a1192aebae2f976f8f63f9571c67dd577fc8daaecf741d3926",
        "linux_arm64"  => "1ad307f582fb13fb866580a7bc797788980bf78d57519146956ddb4d4697a558",
        "linux_amd64"  => "b03bca42451788c194a4a569f4fd4f6544bda3947724b29848619a45d150c9fd",
    }

    arch = "arm64"
    platform = "darwin"
    on_intel do
        arch = "amd64"
    end
    on_linux do
        platform = "linux"
    end

    url "https://d2f391esomvqpi.cloudfront.net/encore-#{release_version}-#{platform}_#{arch}.tar.gz"
    version release_version
    sha256 checksums["#{platform}_#{arch}"]

    def install
        libexec.install Dir["*"]
        bin.install_symlink Dir[libexec/"bin/*"]

        # Install bash completion
        output = Utils.safe_popen_read(bin/"encore", "completion", "bash")
        (bash_completion/"encore").write output

        # Install zsh completion
        output = Utils.safe_popen_read(bin/"encore", "completion", "zsh")
        (zsh_completion/"_encore").write output

        # Install fish completion
        output = Utils.safe_popen_read(bin/"encore", "completion", "fish")
        (fish_completion/"encore.fish").write output
    end

    test do
        system "#{bin}/encore", "check"
    end
end
