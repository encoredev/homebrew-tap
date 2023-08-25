class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230825"
    checksums = {
        "darwin_arm64" => "d6ee2f7137c49ed88288f3d184ad3721dd9402f20c08dafcf4f34211d9a186dd",
        "darwin_amd64" => "94324148091402883b19b59513e700eaeddfbfa8101f9bc78f3f3552adeccd4a",
        "linux_arm64"  => "dcb74b8547707916dcc6bf5270f067ab1ffcc330828b9a8b5f433a95256167ab",
        "linux_amd64"  => "d1a0ff4ca3f5188ec9ed35ae9c9f3a9f061adda1f154047d495b94f615e1b03f",
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
