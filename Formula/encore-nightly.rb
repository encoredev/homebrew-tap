class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230525"
    checksums = {
        "darwin_arm64" => "d353060274cbecce0ce95af31342fa449150b38efbefdb62cde13230be947119",
        "darwin_amd64" => "f57f2d924796872285c1d276e39b0ce3980f1ff8e954933da44bc1848e667480",
        "linux_arm64"  => "26a03061283b40784611792c1d1bc8e46ab15bf6a68741925e447a1412d090a2",
        "linux_amd64"  => "2d57e843b4729e2cce4c3e8f3e3ca3adf69829abf4ae19c99098d306dcead5a9",
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
