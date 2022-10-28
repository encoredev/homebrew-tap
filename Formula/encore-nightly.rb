class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20221028"
    checksums = {
        "darwin_arm64" => "c75dc9c4f88a33e658f0c205cdb4d4d129225542732a18a26613d9922976d981",
        "darwin_amd64" => "81972900a292f2dbc615aac649c30ad9d13095abb743e1855fdf7fe8aec78eb2",
        "linux_arm64"  => "8c992e48ecb94792d15fe0137e025225c0ef098888b91f0361f474657bc843ac",
        "linux_amd64"  => "fa2b12064542f7c3e212aaa0bb3cd95a5d723375e31230ab39e0c0976e4cdc6c",
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
