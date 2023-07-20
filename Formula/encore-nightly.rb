class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230720"
    checksums = {
        "darwin_arm64" => "7e017cb20a7ee434d7fa074a3e5753e5f8c07dd49ab811caa0038b90d789c5ab",
        "darwin_amd64" => "e941777568b84d4163e5a94c6885428ad264d11544da0de766213f20e9318154",
        "linux_arm64"  => "9380c13cd82edda15bce97e52c70474240efb3a9945a96d1ed582bf13ea28789",
        "linux_amd64"  => "870544eba8ed6a5d1d8a3e8d1ed67471b02c3825c18a03092a7eb6e61fe60c9f",
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
