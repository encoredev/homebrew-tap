class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230214"
    checksums = {
        "darwin_arm64" => "9cb6219f0e2621bb083cbb815b761ff7ebf610706e4fe29be5ee90216ea459a5",
        "darwin_amd64" => "25d9cc3c7714210b56e57136cac0c439d8e39ee2e2001ba75d5aca35303574a7",
        "linux_arm64"  => "46600c5d1caee56a724f732248186d540627c596cee42eecccc3aa6ff54d60fd",
        "linux_amd64"  => "e908f0388633b5ebd162de4960c51b65495b9948c9b544b9f8fb4cf055f05dfc",
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
